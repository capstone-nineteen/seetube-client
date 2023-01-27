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
}
