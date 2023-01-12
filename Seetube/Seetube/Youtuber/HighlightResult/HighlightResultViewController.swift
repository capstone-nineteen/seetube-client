//
//  HighlightResultViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/13.
//

import UIKit

class HighlightResultViewController: UIViewController {
    @IBOutlet weak var sceneListView: SceneListLargeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
    }
}

extension HighlightResultViewController {
    private func configureTableView() {
        self.sceneListView.tableView.delegate = self
        self.sceneListView.tableView.dataSource = self
    }
}

extension HighlightResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SceneListLargeTableViewCell.cellHeight + SceneListLargeTableViewCell.cellSpacing
    }
}

extension HighlightResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SceneListLargeTableViewCell.identifier, for: indexPath) as? SceneListLargeTableViewCell else { return UITableViewCell() }
        return cell
    }
}
