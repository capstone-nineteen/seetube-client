//
//  ReviewsInProgressTableViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/19.
//

import UIKit

class ReviewsInProgressTableViewController: VideoInfoCardTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func registerCell() {
        self.tableView.register(ReviewsInProgressTableViewCell.self, forCellReuseIdentifier: ReviewsInProgressTableViewCell.cellReuseIdentifier)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsInProgressTableViewCell.cellReuseIdentifier, for: indexPath) as? ReviewsInProgressTableViewCell else { return UITableViewCell() }
        return cell
    }
}
