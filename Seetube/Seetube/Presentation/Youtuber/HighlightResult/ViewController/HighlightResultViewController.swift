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

    // Video Player
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var timeObserver: Any?

    // View Model
    var viewModel: HighlightResultViewModel?
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }

    @IBAction func saveButtonTouched(_ sender: BottomButton) {
        self.displayOKAlert(title: "저장 완료",
                            message: "하이라이트를 저장했습니다.")
    }
}

// MARK: - ViewModel Extension

extension HighlightResultViewController {
    // TODO: 코드 중복 제거
    func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let viewWillAppear = self.viewWillAppearEvent().debug()
        let itemSelected = self.itemSelectedEvent().debug()
        
        let input = HighlightResultViewModel.Input(
            viewWillAppear: viewWillAppear,
            itemSelected: itemSelected
        )
        let output = viewModel.transform(input: input)
        
        self.bindVideoUrl(output.videoUrl)
        self.bindScenes(output.scenes)
        self.bindPlayingInterval(output.playingInterval)
    }
    
    // MARK: Input Event Creation
    
    func viewWillAppearEvent() -> Driver<Bool> {
        return self.rx.viewWillAppear.asDriver()
    }
    
    func itemSelectedEvent() -> Driver<IndexPath> {
        return self.resultView.rx.tableViewItemSelected.asDriver()
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
}
