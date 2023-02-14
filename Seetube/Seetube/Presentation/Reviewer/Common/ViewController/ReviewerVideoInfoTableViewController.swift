//
//  ReviewerVideoInfoTableViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit
import RxCocoa
import RxSwift

class ReviewerVideoInfoTableViewController: VideoInfoCardTableViewController {
    var viewModels = [ReviewerVideoCardItemViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func registerCell() {
        self.tableView.register(
            ReviewerVideoInfoTableViewCell.self,
            forCellReuseIdentifier: ReviewerVideoInfoTableViewCell.cellReuseIdentifier
        )
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewerVideoInfoTableViewCell.cellReuseIdentifier, for: indexPath) as? ReviewerVideoInfoTableViewCell else { return UITableViewCell() }
        return cell
    }
}

// MARK: - Reactive Extension

extension Reactive where Base: ReviewerVideoInfoTableViewController {
    var viewModels: Binder<[ReviewerVideoCardItemViewModel]> {
        return Binder(base) { (base, viewModels) in
            base.viewModels = viewModels
            base.tableView.reloadData()
        }
    }
    
    var itemSelected: ControlEvent<IndexPath> {
        return base.tableView.rx.itemSelected
    }
}
