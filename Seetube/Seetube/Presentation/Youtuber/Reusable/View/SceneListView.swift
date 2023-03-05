//
//  SceneListView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/12.
//

import UIKit

@IBDesignable
class SceneListView: UIView, NibLoadable {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var title: String? { return self.titleLabel.text }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
        self.configureTableView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadFromNib(owner: self)
        self.configureTableView()
    }
    
    func configureTableView() {
        let sceneListTableViewCellNib = UINib.init(nibName: SceneListTableViewCell.cellReuseIdentifier, bundle: nil)
        self.tableView.register(sceneListTableViewCellNib, forCellReuseIdentifier: SceneListTableViewCell.cellReuseIdentifier)
        self.tableView.layoutMargins = .zero
    }
    
    func configureDelegate(_ delegate: UITableViewDelegate & UITableViewDataSource) {
        self.tableView.delegate = delegate
        self.tableView.dataSource = delegate
    }
    
    func updateTitle(with title: String?) {
        self.titleLabel.text = title
    }
}
