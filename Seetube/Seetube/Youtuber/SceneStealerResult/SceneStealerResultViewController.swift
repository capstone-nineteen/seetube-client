//
//  SceneStealerResultViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/13.
//

import UIKit

class SceneStealerResultViewController: UIViewController {
    @IBOutlet weak var resultView: ListStyleResultView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultView.configureDelegate(self)
    }
}

extension SceneStealerResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SceneListTableViewCell.cellHeight + SceneListTableViewCell.cellSpacing
    }
}

extension SceneStealerResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SceneListTableViewCell.cellReuseIdentifier, for: indexPath) as? SceneListTableViewCell else { return UITableViewCell() }
        cell.setProgress(value: Double((indexPath.row+1))*0.1,
                         text: "\((indexPath.row+1)*10)%",
                         color: UIColor(named: "AccentColor"))
        return cell
    }
}
