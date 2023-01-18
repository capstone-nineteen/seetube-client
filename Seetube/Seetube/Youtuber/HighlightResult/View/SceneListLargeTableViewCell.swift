//
//  SceneListLargeTableViewCell.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/13.
//

import UIKit

class SceneListLargeTableViewCell: UITableViewCell {
    static let cellReuseIdentifier = "SceneListLargeTableViewCell"
    static let cellHeight: CGFloat = 95
    static let cellSpacing: CGFloat = 10
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0,
                                                                               left: 0,
                                                                               bottom: Self.cellSpacing,
                                                                               right: 0))
    }
    
}
