//
//  VideoDetailViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/15.
//

import Foundation

class VideoDetailViewModel {
    let thumbnailImageUrl: String
    let title: String
    let youtuber: String
    let reward: String
    let progressViewModel: ReviewProgressViewModel
    let reviewPeriod: String
    let videoDescription: String
    let hashtags: String
    let shouldEnableBottomButton: Bool
    let buttonTitle: String
    
    init(
        with videoInfo: VideoInfo,
        buttonTitle: String
    ) {
        self.thumbnailImageUrl = videoInfo.imagePath
        self.title = videoInfo.title
        self.youtuber = videoInfo.youtuberName
        self.reward = "\(videoInfo.rewardAmount)"
        self.progressViewModel = ReviewProgressViewModel(
            current: videoInfo.currentNumberOfReviewers,
            target: videoInfo.targetNumberOfReviewers
        )
        let start = videoInfo.reviewStartDate.toyyMMddStyleWithDot()
        let end = videoInfo.reviewEndDate.toyyMMddStyleWithDot()
        self.reviewPeriod = "\(start) - \(end)"
        self.videoDescription = videoInfo.videoDescription
        self.hashtags = "#\(videoInfo.category.rawValue)"
        self.shouldEnableBottomButton = !videoInfo.didReviewed
        self.buttonTitle = buttonTitle
    }
}
