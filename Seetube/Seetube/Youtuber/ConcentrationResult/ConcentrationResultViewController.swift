//
//  ConcentrationResultViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/12.
//

import UIKit

class ConcentrationResultViewController: UIViewController {
    static let storyboardID = "ConcentrationResultViewController"

    @IBOutlet weak var sceneListView: SceneListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
    }
}

extension ConcentrationResultViewController {
    private func configureTableView() {
        self.sceneListView.tableView.delegate = self
        self.sceneListView.tableView.dataSource = self
    }
}

extension ConcentrationResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SceneListTableViewCell.cellHeight + SceneListTableViewCell.cellSpacing
    }
}

extension ConcentrationResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SceneListTableViewCell.identifier, for: indexPath) as? SceneListTableViewCell else { return UITableViewCell() }
        cell.setProgress(value: Double((indexPath.row+1))*0.1,
                         text: "\((indexPath.row+1)*10)%",
                         color: UIColor(named: "AccentColor"))
        return cell
    }
}
