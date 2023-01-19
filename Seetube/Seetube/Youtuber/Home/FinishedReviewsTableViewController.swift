//
//  FinishedReviewsTableViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/19.
//

import UIKit

class FinishedReviewsTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.configureContentInset()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.bounds.width / 16 * 9
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FinishedReviewsTableViewCell.cellReuseIdentifier, for: indexPath) as? FinishedReviewsTableViewCell else { return UITableViewCell() }
        return cell
    }
}

extension FinishedReviewsTableViewController {
    private func registerCell() {
        self.tableView.register(UINib(nibName: FinishedReviewsTableViewCell.cellReuseIdentifier, bundle: nil),
                                forCellReuseIdentifier: FinishedReviewsTableViewCell.cellReuseIdentifier)
    }
    
    private func configureContentInset() {
        self.tableView.contentInset.bottom = 15
    }
}
