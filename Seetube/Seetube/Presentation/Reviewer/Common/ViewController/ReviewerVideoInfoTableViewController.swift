//
//  ReviewerVideoInfoTableViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit

class ReviewerVideoInfoTableViewController: VideoInfoCardTableViewController, ViewControllerPushable {
    override func registerCell() {
        self.tableView.register(ReviewerVideoInfoTableViewCell.self, forCellReuseIdentifier: ReviewerVideoInfoTableViewCell.cellReuseIdentifier)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewerVideoInfoTableViewCell.cellReuseIdentifier, for: indexPath) as? ReviewerVideoInfoTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.moveToVideoDetail()
    }
}

extension ReviewerVideoInfoTableViewController {
    private func moveToVideoDetail() {
        self.push(viewControllerType: ReviewerVideoDetailViewController.self)
    }
}
