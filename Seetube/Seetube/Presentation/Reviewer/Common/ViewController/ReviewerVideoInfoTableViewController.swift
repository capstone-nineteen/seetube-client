//
//  ReviewerVideoInfoTableViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit
import RxCocoa
import RxSwift

class ReviewerVideoInfoTableViewController: VideoInfoCardTableViewController, ViewControllerPushable {
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 비디오 id 전달
        // parent에서 moveTo VideoDetail? 모델이 parent에 있어서..
        self.moveToVideoDetail()
    }
}

// MARK: - Reactive Extension

extension Reactive where Base: ReviewerVideoInfoTableViewController {
    var shouldReload: ControlProperty<[ReviewerVideoCardItemViewModel]> {
        let source = PublishRelay<[ReviewerVideoCardItemViewModel]>()
        let binder = Binder(base) { (base, viewModels) in
            base.viewModels = viewModels
            base.tableView.reloadData()
        }
        return ControlProperty(values: source, valueSink: binder)
    }
}

// MARK: - Scene Trasition

extension ReviewerVideoInfoTableViewController {
    private func moveToVideoDetail() {
        self.push(viewControllerType: ReviewerVideoDetailViewController.self)
    }
}
