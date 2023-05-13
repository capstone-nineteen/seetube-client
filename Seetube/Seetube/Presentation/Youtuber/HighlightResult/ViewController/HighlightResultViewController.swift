//
//  HighlightResultViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/13.
//

import UIKit
import RxCocoa
import RxSwift
import AVFoundation

class HighlightResultViewController: UIViewController,
                                     AlertDisplaying,
                                     ScenePlaying
{
    @IBOutlet weak var resultView: LargeListStyleResultView!
    @IBOutlet weak var saveButton: BottomButton!
    @IBOutlet weak var loadingView: CustomAlertLoadingView!
    
    // Video Player
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var timeObserver: Any?

    // View Model
    var viewModel: HighlightResultViewModel?
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
    }
}

// MARK: - Configuration

extension HighlightResultViewController {
    private func configureUI() {
        self.configureSaveButton()
    }
    
    private func configureSaveButton() {
        self.saveButton.rx.tap
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.loadingView.isHidden = false
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - ViewModel Extension

extension HighlightResultViewController {
    // TODO: 코드 중복 제거
    func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let viewWillAppear = self.viewWillAppearEvent()
        let itemSelected = self.itemSelectedEvent()
        let saveButtonTouched = self.saveButtonTouchedEvent()
        
        let input = HighlightResultViewModel.Input(
            viewWillAppear: viewWillAppear,
            itemSelected: itemSelected,
            saveButtonTouched: saveButtonTouched
        )
        let output = viewModel.transform(input: input)
        
        self.bindVideoUrl(output.videoUrl)
        self.bindScenes(output.scenes)
        self.bindPlayingInterval(output.playingInterval)
        self.bindVideoSaveResult(output.videoSaveResult)
        self.bindShouldRequestAuthorization(output.shouldRequestAuthorization)
    }
    
    // MARK: Input Event Creation
    
    func viewWillAppearEvent() -> Driver<Bool> {
        return self.rx.viewWillAppear.asDriver()
    }
    
    func itemSelectedEvent() -> Driver<IndexPath> {
        return self.resultView.rx.tableViewItemSelected.asDriver()
    }
    
    func saveButtonTouchedEvent() -> Driver<Void> {
        return self.saveButton.rx.tap.asDriver()
    }
    
    // MARK: Output Binding
    
    func bindVideoUrl(_ url: Driver<String>) {
        url
            .drive(with: self) { obj, url in
                obj.createPlayer(url: url, at: self.resultView)
            }
            .disposed(by: self.disposeBag)
    }
    
    func bindScenes(_ scenes: Driver<[SceneLargeItemViewModel]>) {
        self.resultView
            .bind(with: scenes)
            .disposed(by: self.disposeBag)
    }
    
    func bindPlayingInterval(_ interval: Driver<(start: Float, end: Float)>) {
        interval
            .drive(with: self) { obj, interval in
                obj.playInterval(start: interval.start,
                                 end: interval.end)
            }
            .disposed(by: self.disposeBag)
    }
    
    func bindVideoSaveResult(_ result: Driver<Bool>) {
        result
            .drive(with: self) { obj, success in
                obj.loadingView.isHidden = true
                
                if success {
                    obj.displaySaveSucceedAlert()
                } else {
                    obj.displaySaveFailedAlert()
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    func bindShouldRequestAuthorization(_ shouldRequestAuthorization: Driver<Void>) {
        shouldRequestAuthorization
            .drive(with: self) { obj, _ in
                obj.displayAuthorizationNeededAlert()
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Alerts

extension HighlightResultViewController {
    private func displaySaveSucceedAlert() {
        self.displayOKAlert(title: "저장 완료",
                            message: "하이라이트를 저장했습니다.")
    }
    
    private func displaySaveFailedAlert() {
        self.displayFailureAlert(message: "저장에 실패했습니다. 다시 시도해주세요.")
    }
    
    private func displayAuthorizationNeededAlert() {
        self.displayOpenSettingsAlert(title: "권한 필요",
                                      message: "사진앱에 저장하기 위해서는 접근 권한이 필요합니다.")
    }
}
