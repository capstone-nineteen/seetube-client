//
//  FinishedReviewsTableViewCell.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/20.
//

import UIKit

class FinishedReviewsTableViewCell: VideoInfoCardTableViewCell {
    static let cellReuseIdentifier = "FinishedReviewsTableViewCell"
    
    func bind(_ viewModel: YoutuberFinishedVideoCardItemViewModel) {
        self.videoInfoCardView.bind(title: viewModel.title,
                                    youtuberName: viewModel.youtuberName,
                                    date: viewModel.period,
                                    personnel: viewModel.numberOfReviewers,
                                    thumbnailUrl: viewModel.thumbnailUrl)
    }
}
