//
//  ConcentrationResultViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/12.
//

import UIKit
import RxCocoa
import RxSwift
import AVFoundation

class ConcentrationResultViewController: UIViewController,
                                         ScenePlaying
{
    @IBOutlet weak var resultView: ListStyleResultView!
    
    // Video Player
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var timeObserver: Any?
    
    // View Model
    var viewModel: ConcentrationResultViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
}

// MARK: - ViewModel Binding

extension ConcentrationResultViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let viewWillAppear = self.viewWillAppearEvent()
        let itemSelected = self.itemSelectedEvent()
        
        let input = ConcentrationResultViewModel.Input(
            viewWillAppear: viewWillAppear,
            itemSelected: itemSelected
        )
        let output = viewModel.transform(input: input)
        
        self.bindVideoUrl(output.videoUrl)
        self.bindScenes(output.scenes)
        self.bindPlayingInterval(output.playingInterval)
    }
    
    // MARK: Input Event Creation
    
    private func viewWillAppearEvent() -> Driver<Bool> {
        return self.rx.viewWillAppear.asDriver()
    }
    
    private func itemSelectedEvent() -> Driver<IndexPath> {
        return self.resultView.rx.tableViewItemSelected.asDriver()
    }
    
    // MARK: Output Binding
    
    private func bindVideoUrl(_ url: Driver<String>) {
        url
            .drive(with: self) { obj, url in
                obj.createPlayer(url: url, at: self.resultView)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindScenes(_ scenes: Driver<[SceneItemViewModel]>) {
        self.resultView
            .bind(with: scenes)
            .disposed(by: self.disposeBag)
    }
    
    private func bindPlayingInterval(_ interval: Driver<(start: Int, end: Int)>) {
        interval
            .drive(with: self) { obj, interval in
                obj.playInterval(start: interval.start,
                                 end: interval.end)
            }
            .disposed(by: self.disposeBag)
    }
}
