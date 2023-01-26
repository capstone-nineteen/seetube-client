//
//  SearchResultTableViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/26.
//

import UIKit

class SearchResultTableViewController: VideoInfoCardTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func registerCell() {
        self.tableView.register(ReviewerVideoInfoTableViewCell.self, forCellReuseIdentifier: ReviewerVideoInfoTableViewCell.cellReuseIdentifier)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewerVideoInfoTableViewCell.cellReuseIdentifier, for: indexPath) as? ReviewerVideoInfoTableViewCell else { return UITableViewCell() }
        return cell
    }
}
