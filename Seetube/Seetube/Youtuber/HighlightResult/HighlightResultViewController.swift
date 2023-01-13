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
        // TODO: largeView 더 큰 뷰로 수정, 테이블뷰 델리게이트 설정
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SceneListLargeTableViewCell.cellReuseIdentifier, for: indexPath) as? SceneListLargeTableViewCell else { return UITableViewCell() }
        return cell
    }
}
