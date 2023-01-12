//
//  SceneListTableViewCell.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/12.
//

import UIKit

class SceneListTableViewCell: UITableViewCell {
    static let identifier = "SceneListTableViewCell"
    static let cellHeight: CGFloat = 80
    static let cellSpacing: CGFloat = 10
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var timeIntervalLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var progressBar: CircularProgressBar!
    
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
    
    func setProgress(value: Double, text: String?, color: UIColor?) {
        self.progressBar.setProgress(value: value, text: text ?? "", color: color)
    }
}
