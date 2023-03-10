//
//  YoutuberHomeTableViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/20.
//

import UIKit

class VideoInfoCardTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.configureStyle()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.bounds.width / 16 * 9
    }
    
    func registerCell() { }
    
    func configureStyle() {
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.contentInset.bottom = 15
    }
}
