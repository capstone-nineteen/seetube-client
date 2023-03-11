//
//  SceneStealerResultViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/13.
//

import UIKit
import RxCocoa
import RxSwift

class SceneStealerResultViewController: UIViewController {
    @IBOutlet weak var resultView: ListStyleImageResultView!
    
    var viewModel: SceneStealerResultViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
}

// MARK: - ViewModel Binding

extension SceneStealerResultViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let viewWillAppear = self.viewWillAppearEvent().debug()
        let itemSelected = self.itemSelectedEvent().debug()
        
        let input = SceneStealerResultViewModel.Input(
            viewWillAppear: viewWillAppear,
            itemSelected: itemSelected
        )
        let output = viewModel.transform(input: input)
        
        self.bindImageUrl(output.imageUrl)
        self.bindScenes(output.scenes)
    }
    
    // MARK: Input Event Creation
    
    func viewWillAppearEvent() -> Driver<Bool> {
        return self.rx.viewWillAppear.asDriver()
    }
    
    func itemSelectedEvent() -> Driver<IndexPath> {
        return self.resultView.rx.tableViewItemSelected.asDriver()
    }
    
    // MARK: Output Binding
    
    func bindImageUrl(_ url: Driver<String>) {
        url
            .drive(self.resultView.rx.selectedThumbnailUrl)
            .disposed(by: self.disposeBag)
    }
    
    func bindScenes(_ scenes: Driver<[SceneItemViewModel]>) {
        self.resultView
            .bind(with: scenes)
            .disposed(by: self.disposeBag)
    }
}
