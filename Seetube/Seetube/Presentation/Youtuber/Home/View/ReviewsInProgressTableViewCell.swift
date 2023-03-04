//
//  ReviewsInProgressTableViewCell.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/20.
//

import UIKit

class ReviewsInProgressTableViewCell: VideoInfoCardTableViewCell {
    static let cellReuseIdentifier = "ReviewsInProgressTableViewCell"
    
    private lazy var progressLabel: AdaptiveFontSizeLabel = {
        let label = AdaptiveFontSizeLabel()
        label.textColor = Colors.seetubePink
        label.font = label.font.withWeight(.semibold)
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureAccessoryView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureAccessoryView()
    }
    
    private func configureAccessoryView() {
        self.videoInfoCardView.configureAccessoryView(self.progressLabel)
    }
    
    func bind(_ viewModel: YoutuberInProgressVideoCardItemViewModel) {
        self.videoInfoCardView.bind(viewModel)
        self.progressLabel.text = viewModel.progressPercentage
    }
}
