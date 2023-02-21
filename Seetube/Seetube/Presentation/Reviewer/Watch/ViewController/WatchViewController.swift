//
//  CalibraiontViewController.swift
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

class WatchViewController: UIViewController {
    @IBOutlet weak var caliPointView: CircularProgressBar!
    @IBOutlet weak var caliTutorialView: CalibrationTutorialView!
    @IBOutlet weak var xButton: UIButton!
    
    // Eye-tracking
    private var gazeTracker: GazeTracker?
    
    // View Model
    var viewModel: WatchViewModel?
    private var disposeBag = DisposeBag()
    
    // TODO: RxSeeSo
    let watchingState = BehaviorRelay<WatchingState>(value: .calibrationPending)
    
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
                obj.xButton.isHidden = true
                obj.caliTutorialView.isHidden = true

                DispatchQueue.global().async { [weak self] in
                    self?.gazeTracker?.startTracking()
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    private func configureXButton() {
        self.xButton.rx.tap
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
        
        self.rx.viewDidDisappear
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.gazeTracker?.stopTracking()
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - ViewModel Binding

extension WatchViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let watchingState = self.watchingStateProperty()
        
        let input = WatchViewModel.Input(watchingState: watchingState)
        let output = viewModel.transform(input: input)
    }
    
    // MARK: Input Event Creation
    
    private func watchingStateProperty() -> Driver<WatchingState> {
        return self.watchingState.asDriver()
    }
}

// MARK: - Eye Tracking

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
        GazeTracker.initGazeTracker(license: SeeSo.licenseKey,
                                    delegate: self)
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
        let result = self.gazeTracker?.startCalibration(mode: .FIVE_POINT,
                                                        criteria: .HIGH)
        if let didStart = result,
           !didStart {
            self.watchingState.accept(.calibrationStartFailed)
        } else {
            self.watchingState.accept(.calibrationStartSucceeded)
        }
    }
    
    private func stopCalibration(){
        self.gazeTracker?.stopCalibration()
        self.watchingState.accept(.calibrationFinished)
        DispatchQueue.main.async {
            self.caliPointView.isHidden = true
            self.xButton.isHidden = true
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
            if let result = self.gazeTracker?.startCollectSamples() {
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
        guard let isCalibrating = self.gazeTracker?.isCalibrating(),
              !isCalibrating else { return }
        // TODO: Gaze Info 업데이트
    }
}

// MARK: ImageDelegate

extension WatchViewController: ImageDelegate {
    func onImage(timestamp: Double, image: CMSampleBuffer) {
        DispatchQueue.global().async {
            if let frame = CMSampleBufferGetImageBuffer(image) {
                // TODO: face detection
            } else {
                self.watchingState.accept(.failedToGetImage)
            }
        }
    }
}
