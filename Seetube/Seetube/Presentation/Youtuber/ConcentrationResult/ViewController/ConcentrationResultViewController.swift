//
//  ConcentrationResultViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/12.
//

import UIKit
import RxCocoa
import RxSwift

class ConcentrationResultViewController: UIViewController {
    @IBOutlet weak var resultView: ListStyleResultView!
    
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
        // TODO: 영상 로드
    }
    
    private func bindScenes(_ scenes: Driver<[SceneItemViewModel]>) {
        self.resultView
            .bind(with: scenes)
            .disposed(by: self.disposeBag)
    }
    
    private func bindPlayingInterval(_ interval: Driver<(start: Int, end: Int)>) {
        // TODO: 영상 재생 구간 설정
        interval.drive().disposed(by: self.disposeBag)
    }
}

