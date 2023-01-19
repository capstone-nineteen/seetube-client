//
//  FinishedReviewsTableViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/19.
//

import UIKit

class FinishedReviewsTableViewController: YoutuberHomeTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func registerCell() {
        self.tableView.register(FinishedReviewsTableViewCell.self, forCellReuseIdentifier: FinishedReviewsTableViewCell.cellReuseIdentifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FinishedReviewsTableViewCell.cellReuseIdentifier, for: indexPath) as? FinishedReviewsTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushResultMenu()
    }
}

extension FinishedReviewsTableViewController {
    private func pushResultMenu() {
        guard let resultMenuViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResultMenuViewController") else { return }
        self.navigationController?.pushViewController(resultMenuViewController, animated: true)
    }
}
