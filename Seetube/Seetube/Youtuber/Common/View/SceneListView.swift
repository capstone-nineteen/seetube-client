//
//  SceneListView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/12.
//

import UIKit

@IBDesignable
class SceneListView: UIView, NibLoadable {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBInspectable var title: String? {
        set { self.titleLabel.text = newValue }
        get { return self.titleLabel.text }
    }
    
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
        let sceneListTableViewCellNib = UINib.init(nibName: SceneListTableViewCell.identifier, bundle: nil)
        self.tableView.register(sceneListTableViewCellNib, forCellReuseIdentifier: SceneListTableViewCell.identifier)
    }
}
