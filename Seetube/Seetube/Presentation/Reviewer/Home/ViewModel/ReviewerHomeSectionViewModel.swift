//
//  ReviewerHomeSectionViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/10.
//

import Foundation

class VideoItemViewModel {
    let title: String
    let youtuberName: String
    let remainingPeriod: String
    let progress: String
    let rewardAmount: String
    
    init(with videoInfo: VideoInfo) {
        self.title = videoInfo.title
        self.youtuberName = videoInfo.youtuberName
        self.remainingPeriod = "남은 기간 \(videoInfo.reviewEndDate.dday())일"
        self.progress = "\(videoInfo.currentNumberOfReviewers)/\(videoInfo.targetNumberOfReviewers)명"
        self.rewardAmount = "\(videoInfo.rewardAmount)"
    }
}

class ReviewerHomeSectionViewModel {
    let title: String
    let videos: [ReviewerHomeVideoItemViewModel]
    
    init(with section: ReviewerHomeSection) {
        self.title = section.title
        self.videos = section.videos.map { VideoItemViewModel(with: $0) }
    }
}
