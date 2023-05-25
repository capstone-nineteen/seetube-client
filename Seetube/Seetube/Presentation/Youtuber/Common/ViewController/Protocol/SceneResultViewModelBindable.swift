//
//  SceneResultViewModelBindable.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/07.
//

import UIKit
import RxCocoa
import RxSwift

protocol SceneResultViewModelBindable: ScenePlaying {
    var resultView: ListStyleResultView! { get set }
    var viewModel: SceneResultViewModel? { get set }
    var disposeBag: DisposeBag { get set }
    
    func bindViewModel()
}

extension SceneResultViewModelBindable {
    func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let viewWillAppear = self.viewWillAppearEvent()
        let itemSelected = self.itemSelectedEvent()
        
        let input = SceneResultViewModel.Input(
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
    
    func bindScenes(_ scenes: Driver<[SceneItemViewModel]>) {
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
}
