//
//  ListStyleResultView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/14.
//

import UIKit

class ListStyleResultView: UIView, NibLoadable {
    @IBOutlet weak var sceneListView: SceneListView!
    
    @IBInspectable var title: String? {
        set { self.sceneListView.updateTitle(with: newValue) }
        get { return self.sceneListView.title }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadFromNib(owner: self)
    }

    func configureDelegate(_ delegate: UITableViewDelegate & UITableViewDataSource) {
        self.sceneListView.configureDelegate(delegate)
    }
}
