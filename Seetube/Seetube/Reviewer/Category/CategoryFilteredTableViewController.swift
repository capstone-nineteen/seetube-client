//
//  CategoryFilteredTableViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit

class CategoryFilteredTableViewController: ReviewerVideoInfoTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.moveToVideoDetail()
    }
    
    private func moveToVideoDetail() {
        guard let reviewerVideoDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ReviewerVideoDetailViewController") else { return }
        self.navigationController?.pushViewController(reviewerVideoDetailViewController, animated: true)
    }
}
