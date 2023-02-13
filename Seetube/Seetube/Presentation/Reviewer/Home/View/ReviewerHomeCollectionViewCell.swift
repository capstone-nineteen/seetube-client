//
//  ReviewerHomeCollectionViewCell.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/28.
//

import UIKit

class ReviewerHomeCollectionViewCell: UICollectionViewCell {
    static let cellReuseIdentifier = "ReviewerHomeCollectionViewCell"
    
    private lazy var videoInfoCardView = VideoInfoCardView()
    private lazy var priceAccessoryView = PriceAccessoryView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureSubviews()
        self.configureAccessoryView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureSubviews()
        self.configureAccessoryView()
    }
    
    private func configureSubviews() {
        self.addSubview(self.videoInfoCardView)
        self.videoInfoCardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.videoInfoCardView.topAnchor.constraint(equalTo: self.topAnchor),
            self.videoInfoCardView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.videoInfoCardView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.videoInfoCardView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func configureAccessoryView() {
        self.videoInfoCardView.configureAccessoryView(self.priceAccessoryView)
    }
    
    func bind(_ viewModel: ReviewerHomeVideoItemViewModel) {
        self.videoInfoCardView.bind(videoTitle: viewModel.title,
                                    youtuberName: viewModel.youtuberName,
                                    date: viewModel.remainingPeriod,
                                    personnel: viewModel.progress)
        self.priceAccessoryView.bind(viewModel.rewardAmount)
    }
}
