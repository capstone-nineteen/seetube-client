//
//  FinishedReviewsTableViewCell.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/20.
//

import UIKit

class FinishedReviewsTableViewCell: UITableViewCell {
    static let cellReuseIdentifier = "FinishedReviewsTableViewCell"
    
    @IBOutlet weak var videoInfoCardView: VideoInfoCardView!
    
    private lazy var progressLabel: AdaptiveFontSizeLabel = {
        let label = AdaptiveFontSizeLabel()
        label.textColor = UIColor(named: "AccentColor")
        label.text = "20%"
        label.font = label.font.withWeight(.semibold)
        label.textAlignment = .right
        return label
    }()
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.videoInfoCardView.alpha = 0.5
        } else {
            self.videoInfoCardView.alpha = 1.0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureAccessoryView()
    }
    
    private func configureAccessoryView() {
        self.videoInfoCardView.configureAccessoryView(self.progressLabel)
    }
}
