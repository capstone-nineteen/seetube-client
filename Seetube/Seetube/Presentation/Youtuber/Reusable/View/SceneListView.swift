//
//  SceneListView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/12.
//

import UIKit
import RxCocoa
import RxSwift

@IBDesignable
class SceneListView: UIView, NibLoadable {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var title: String? { return self.titleLabel.text }
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
        self.configureTableView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadFromNib(owner: self)
        self.configureTableView()
    }
    
    func configureTableView() {
        let sceneListTableViewCellNib = UINib.init(nibName: SceneListTableViewCell.cellReuseIdentifier,
                                                   bundle: nil)
        self.tableView.register(sceneListTableViewCellNib,
                                forCellReuseIdentifier: SceneListTableViewCell.cellReuseIdentifier)
        
        self.tableView.layoutMargins = .zero
        
        Driver<CGFloat>.just(SceneListTableViewCell.cellHeight)
            .drive(self.tableView.rx.rowHeight)
            .disposed(by: self.disposeBag)
        
        self.tableView.rx.itemSelected
            .asDriver()
            .drive(with: self) { obj, indexPath in
                obj.tableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: self.disposeBag)
    }
    
    func updateTitle(with title: String?) {
        self.titleLabel.text = title
    }
    
    func bind(with viewModels: Driver<[SceneItemViewModel]>) -> Disposable {
        return viewModels
            .drive(
                self.tableView.rx.items(
                    cellIdentifier: SceneListTableViewCell.cellReuseIdentifier,
                    cellType: SceneListTableViewCell.self
                )
            ) { row, viewModel, cell in
                cell.bind(viewModel)
            }
    }
}

// MARK: - Reactive Extension

extension Reactive where Base: SceneListView {
    var tableViewItemSelected: ControlEvent<IndexPath> {
        return base.tableView.rx.itemSelected
    }
}
