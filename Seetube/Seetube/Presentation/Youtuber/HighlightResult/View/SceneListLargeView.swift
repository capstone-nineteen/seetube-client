//
//  SceneListLargeView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/13.
//

import UIKit
import RxCocoa
import RxSwift

class SceneListLargeView: SceneListView {
    override func registerTableViewCell() {
        let sceneListLargeTableViewCellNib = UINib.init(nibName: SceneListLargeTableViewCell.cellReuseIdentifier, bundle: nil)
        self.tableView.register(sceneListLargeTableViewCellNib, forCellReuseIdentifier: SceneListLargeTableViewCell.cellReuseIdentifier)
    }
    
    override func configureTableViewCellHeight() {
        Driver<CGFloat>.just(SceneListLargeTableViewCell.cellHeight)
            .drive(self.tableView.rx.rowHeight)
            .disposed(by: self.disposeBag)
    }
    
    func bind(with viewModels: Driver<[SceneLargeItemViewModel]>) -> Disposable {
        return viewModels
            .drive(
                self.tableView.rx.items(
                    cellIdentifier: SceneListLargeTableViewCell.cellReuseIdentifier,
                    cellType: SceneListLargeTableViewCell.self
                )
            ) { row, viewModel, cell in
                cell.bind(viewModel)
            }
    }
}
