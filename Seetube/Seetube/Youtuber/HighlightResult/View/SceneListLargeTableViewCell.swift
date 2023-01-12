//
//  SceneListLargeTableViewCell.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/13.
//

import UIKit

class SceneListLargeTableViewCell: UITableViewCell {
    static let identifier = "SceneListLargeTableViewCell"
    static let cellHeight: CGFloat = 95
    static let cellSpacing: CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0,
                                                                               left: 0,
                                                                               bottom: Self.cellSpacing,
                                                                               right: 0))
    }
    
}
