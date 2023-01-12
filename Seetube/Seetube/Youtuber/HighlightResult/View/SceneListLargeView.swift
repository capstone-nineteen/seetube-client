//
//  SceneListLargeView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/13.
//

import UIKit

class SceneListLargeView: SceneListView {
    override func configureTableView() {
        let sceneListLargeTableViewCellNib = UINib.init(nibName: SceneListLargeTableViewCell.identifier, bundle: nil)
        self.tableView.register(sceneListLargeTableViewCellNib, forCellReuseIdentifier: SceneListLargeTableViewCell.identifier)
    }
}
