//
//  WatchViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/19.
//

import UIKit
import SeeSo
import CoreMedia
import AVFoundation
import RxCocoa
import RxSwift

class WatchViewController: UIViewController,
                           AlertDisplaying
{
    @IBOutlet weak var caliPointView: CircularProgressBar!
    @IBOutlet weak var caliTutorialView: CalibrationTutorialView!
    @IBOutlet weak var videoPlayerView: UIView!
    
    // Eye-tracking
    private var gazeTracker: GazeTracker?
    private let watchingState = BehaviorRelay<WatchingState>(value: .calibrationPending)    // TODO: RxSeeSo
    private let gazeInfo = PublishRelay<GazeInfo>()
    
    // Facial Emotion Recognition
    private let faceExpressionPredictor = FaceExpressionPredictor()
    private let frontCameraCapture = PublishRelay<CVImageBuffer>()

    // Raw Review Data
    private let rawReview = PublishSubject<RawReview>()
    
    // View Model
    var viewModel: WatchViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let videoPlayerViewController = segue.destination as? VideoPlayerViewController,
           let viewModel = self.viewModel {
            videoPlayerViewController.viewModel = viewModel.videoPlayerViewModel
        }
    }
}

// MARK: - Configuration

extension WatchViewController {
    private func configureUI() {
        self.configureCaliTutorialView()
        self.configureXButton()
        self.configureGazeTracker()
    }
    
    private func configureCaliTutorialView() {
        self.caliTutorialView.rx.startButtonTap
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.caliTutorialView.isHidden = true

                DispatchQueue.global().async { [weak self] in
                    self?.gazeTracker?.startTracking()
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    private func configureXButton() {
        self.caliTutorialView.rx.xButtonTap
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.dismiss(animated: true)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func configureGazeTracker() {
        self.rx.viewDidAppear
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.authorizeAVCaptureDevice()
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - ViewModel Binding

extension WatchViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let watchingState = self.watchingStateProperty()
        let reviewData = self.rawReviewProperty()
        
        let input = WatchViewModel.Input(watchingState: watchingState,
                                         rawReview: reviewData)
        let output = viewModel.transform(input: input)
        
        self.bindPlayTimeAndVideoRect(playTime: output.playTime,
                                      videoRect: output.videoRect)
        self.bindDidPlayToEndTime(output.didPlayToEndTime)
        self.bindIsAbusingDetected(output.isAbusingDetected)
        self.bindReviewSubmissionResult(output.reviewSubmissionResult)
    }
    
    // MARK: Input Event Creation
    
    private func watchingStateProperty() -> Driver<WatchingState> {
        return self.watchingState.asDriver()
    }
    
    private func rawReviewProperty() -> Observable<RawReview> {
        return self.rawReview.asObservable()
    }
    
    // MARK: Output Binding
    
    private func bindPlayTimeAndVideoRect(playTime: Driver<Int>, videoRect: Driver<VideoRect>) {
        let gazeAndCapture = Observable
            .combineLatest(
                self.gazeInfo,
                self.frontCameraCapture,
                videoRect.asObservable()
            ) { ($0, $1, $2) }
        
        playTime
            .asObservable()
            .withLatestFrom(gazeAndCapture) {
                (playTime: $0, gaze: $1.0, capture: $1.1, videoRect: $1.2)
            }
            .flatMap { [weak self] rawData -> Observable<RawReview> in
                guard let predictor = self?.faceExpressionPredictor else {
                    let gazeAndEmotion = RawReview(playTime: rawData.playTime,
                                                    videoRect: rawData.videoRect,
                                                    gaze: rawData.gaze,
                                                    prediction: nil)
                    return .just(gazeAndEmotion)
                }
                return predictor
                    .makePredictions(for: rawData.capture)
                    .map { $0 as FaceExpressionPredictor.Prediction? }
                    .catchAndReturn(nil)
                    .map {
                        RawReview(playTime: rawData.playTime,
                                   videoRect: rawData.videoRect,
                                   gaze: rawData.gaze,
                                   prediction: $0)
                    }
            }
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .bind(to: self.rawReview)
            .disposed(by: self.disposeBag)
    }
    
    private func bindDidPlayToEndTime(_ didPlayToEndTime: Driver<Void>) {
        didPlayToEndTime
            .drive(with: self) { obj, _ in
                obj.gazeTracker?.stopTracking()
                obj.gazeTracker = nil
                obj.rawReview.onCompleted()
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindIsAbusingDetected(_ isAbusingDetected: Driver<Void>) {
        isAbusingDetected
            .drive(with: self) { obj, _ in
                obj.displayAbusingDetected()
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindReviewSubmissionResult(_ reviewSubmissionResult: Driver<Bool>) {
        reviewSubmissionResult
            .drive(with: self) { obj, isSuccess in
                if isSuccess {
                    obj.displayReviewSubmissionSuccess()
                } else {
                    obj.displayReviewSubmissionFailure()
                }
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Eye Tracking & Facial Emotion Recognition

// MARK: Gaze Tracker Initialization

extension WatchViewController {
    private func authorizeAVCaptureDevice() {
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            self.initializeGazeTracker()
        } else {
            AVCaptureDevice.requestAccess(for: .video) { [weak self] response in
                if response {
                    self?.initializeGazeTracker()
                }
            }
        }
    }
    
    private func initializeGazeTracker() {
        DispatchQueue.global().async {
            GazeTracker.initGazeTracker(license: SeeSo.licenseKey,
                                        delegate: self)
        }
    }
}

// MARK: InitializationDelegate

extension WatchViewController: InitializationDelegate {
    func onInitialized(tracker: GazeTracker?, error: InitializationError) {
        if let tracker = tracker {
            self.watchingState.accept(.trackerInitializationSucceeded)
            
            tracker.setDelegates(statusDelegate: self,
                                 gazeDelegate: self,
                                 calibrationDelegate: self,
                                 imageDelegate: self)
            self.gazeTracker = tracker
            
            DispatchQueue.main.async { [weak self] in
                self?.caliTutorialView.hideLoader()
            }
        } else {
            self.watchingState.accept(.trackerInitializationFailed)
        }
    }
}

// MARK: StatusDelegate

extension WatchViewController: StatusDelegate {
    func onStarted() {
        self.watchingState.accept(.trackingStarted)
        self.startCalibration()
    }
    
    func onStopped(error: StatusError) {
        self.watchingState.accept(.trackingStoppped)
    }
}

// MARK: CalibrationDelegate

extension WatchViewController : CalibrationDelegate {
    private func startCalibration() {
        DispatchQueue.global().async {
            let result = self.gazeTracker?.startCalibration(mode: .FIVE_POINT,
                                                            criteria: .HIGH)
            if let didStart = result,
               !didStart {
                self.watchingState.accept(.calibrationStartFailed)
            } else {
                self.watchingState.accept(.calibrationStartSucceeded)
            }
        }
    }
    
    private func stopCalibration(){
        self.gazeTracker?.stopCalibration()
        DispatchQueue.main.async {
            self.caliPointView.isHidden = true
            self.videoPlayerView.isHidden = false
        }
    }
    
    func onCalibrationProgress(progress: Double) {
        DispatchQueue.main.async {
            self.caliPointView.setProgress(value: progress,
                                      text: "",
                                      color: Colors.seetubePink)
        }
    }
    
    func onCalibrationNextPoint(x: Double, y: Double) {
        DispatchQueue.main.async {
            self.caliPointView.isHidden = false
            self.caliPointView.center = CGPoint(x: x, y: y)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            if let _ = self.gazeTracker?.startCollectSamples() {
            } else {
                self.watchingState.accept(.calibrationFailed)
            }
        })
    }
    
    func onCalibrationFinished(calibrationData : [Double]) {
        self.watchingState.accept(.calibrationFinished)
        self.stopCalibration()
    }
}

// MARK: GazeDelegate

extension WatchViewController: GazeDelegate {
    func onGaze(gazeInfo : GazeInfo) {
        DispatchQueue.global().async { [weak self] in
            guard let isCalibrating = self?.gazeTracker?.isCalibrating(),
                  !isCalibrating else { return }
            self?.gazeInfo.accept(gazeInfo)
        }
    }
}

// MARK: ImageDelegate

extension WatchViewController: ImageDelegate {
    func onImage(timestamp: Double, image: CMSampleBuffer) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self,
                  let gazeTracker = self.gazeTracker,
                  !gazeTracker.isCalibrating() else { return }
            if let frame = CMSampleBufferGetImageBuffer(image) {
                self.frontCameraCapture.accept(frame)
            } else {
                self.watchingState.accept(.failedToGetImage)
            }
        }
    }
}

// MARK: - Alerts

extension WatchViewController {
    private func displayReviewSubmissionSuccess() {
        self.displayOKAlert(
            title: "시청 완료",
            message: "리뷰에 참여해주셔서 감사합니다. 보상이 지급되었습니다."
        ) { [weak self] _ in
            self?.dismiss(animated: true)
        }
    }
    
    private func displayReviewSubmissionFailure() {
        self.displayFailureAlert(
            message: "죄송합니다. 문제가 발생하여 리뷰 제출에 실패하였습니다. 다시 시도해 주세요."
        ) { [weak self] _ in
            self?.dismiss(animated: true)
        }
    }
    
    private func displayAbusingDetected() {
        self.displayFailureAlert(
            message: "영상의 20% 이상에서 얼굴 이탈/화면 밖 응시가 감지되었습니다. 어뷰징으로 판단하여 리뷰를 강제 종료합니다."
        ) { [weak self] _ in
            self?.dismiss(animated: true)
        }
    }
}
