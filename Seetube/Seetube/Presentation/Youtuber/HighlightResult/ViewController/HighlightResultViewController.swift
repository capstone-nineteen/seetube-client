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
                // TODO: Activity Indicator 보여주기
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
    
    func bindPlayingInterval(_ interval: Driver<(start: Int, end: Int)>) {
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
                // TODO: Activity Indicator 제거
                if success {
                    obj.displayOKAlert(title: "저장 완료", message: "하이라이트 영상을 사진앱에 저장했습니다.")
                } else {
                    obj.displayFailureAlert(message: "저장에 실패하였습니다. 다시 시도해주세요.")
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    func bindShouldRequestAuthorization(_ shouldRequestAuthorization: Driver<Void>) {
        shouldRequestAuthorization
            .drive(with: self) { obj, _ in
                let settingsAction: AlertAction = { _ in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }

                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: nil)
                    }
                }
                
                obj.displayAlertWithAction(title: "접근 권한 필요",
                                           message: "영상을 저장하려면 사진앱에 대한 접근 권한이 필요합니다. 권한을 허용해주세요.",
                                           action: settingsAction)
            }
            .disposed(by: self.disposeBag)
    }
}
