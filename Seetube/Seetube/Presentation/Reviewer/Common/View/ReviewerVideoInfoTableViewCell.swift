//
//  ReviewerVideoInfoTableViewCell.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/26.
//

import UIKit

class ReviewerVideoInfoTableViewCell: VideoInfoCardTableViewCell {
    static let cellReuseIdentifier = "ReviewerVideoInfoTableViewCell"
    
    private lazy var priceAccessoryView = PriceAccessoryView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureAccessoryView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureAccessoryView()
    }
    
    private func configureAccessoryView() {
        self.videoInfoCardView.configureAccessoryView(self.priceAccessoryView)
    }
    
    func bind(_ viewModel: ReviewerVideoCardItemViewModel) {
        self.videoInfoCardView.bind(videoTitle: viewModel.title,
                                    youtuberName: viewModel.youtuberName,
                                    date: viewModel.remainingPeriod,
                                    personnel: viewModel.progress,
                                    thumbnailUrl: viewModel.thumbnailUrl)
        self.priceAccessoryView.bind(price: viewModel.rewardAmount)
    }
}
