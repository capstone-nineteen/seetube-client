//
//  ReviewerHomeVideoItemViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/14.
//

import Foundation

class ReviewerVideoCardItemViewModel {
    let title: String
    let youtuberName: String
    let remainingPeriod: String
    let progress: String
    let rewardAmount: String
    let thumbnailUrl: String
    
    init(with videoInfo: VideoInfo) {
        self.title = videoInfo.title
        self.youtuberName = videoInfo.youtuberName
        self.remainingPeriod = "🕔 남은 기간 \(videoInfo.reviewEndDate.dday())일"
        self.progress = "👤 \(videoInfo.currentNumberOfReviewers)/\(videoInfo.targetNumberOfReviewers)명"
        self.rewardAmount = "\(videoInfo.rewardAmount)"
        self.thumbnailUrl = videoInfo.imagePath
    }
}
