//
//  FinishedReviewsTableViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/19.
//

import UIKit
import RxCocoa
import RxSwift

class FinishedReviewsTableViewController: VideoInfoCardTableViewController, ViewControllerPushable {
    fileprivate var viewModels = [YoutuberFinishedVideoCardItemViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func registerCell() {
        self.tableView.register(FinishedReviewsTableViewCell.self, forCellReuseIdentifier: FinishedReviewsTableViewCell.cellReuseIdentifier)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FinishedReviewsTableViewCell.cellReuseIdentifier, for: indexPath) as? FinishedReviewsTableViewCell else { return UITableViewCell() }
        cell.bind(self.viewModels[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 부모 뷰컨트롤러로 전달
        self.moveToResultMenu()
    }
}

extension FinishedReviewsTableViewController {
    private func moveToResultMenu() {
        self.push(viewControllerType: ResultMenuViewController.self)
    }
}

// MARK: - Reactive Extension

extension Reactive where Base: FinishedReviewsTableViewController {
    var viewModels: Binder<[YoutuberFinishedVideoCardItemViewModel]> {
        return Binder(base) { (base, viewModels) in
            base.viewModels = viewModels
            base.tableView.reloadSections([0], with: .automatic)
        }
    }
    
    var itemSelected: ControlEvent<IndexPath> {
        return base.tableView.rx.itemSelected
    }
}
