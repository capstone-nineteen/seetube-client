//
//  VideoInfo.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

struct VideoInfo {
    let videoId: Int
    let title: String
    let youtuberName: String
    let rewardAmount: Int
    let currentNumberOfReviewers: Int
    let targetNumberOfReviewers: Int
    let reviewStartDate: Date
    let reviewEndDate: Date
    let videoDescription: String
    let imagePath: String
    let videoPath: String
    var didReviewed: Bool
    let category: Category

    init(
        videoId: Int = 0,
        title: String = "",
        youtuberName: String = "",
        rewardAmount: Int = 0,
        currentNumberOfReviewers: Int = 0,
        targetNumberOfReviewers: Int = 0,
        reviewStartDate: Date = Date(),
        reviewEndDate: Date = Date(),
        videoDescription: String = "",
        imagePath: String = "",
        videoPath: String = "",
        didReviewed: Bool = false,
        category: Category = .all
    ) {
        self.videoId = videoId
        self.title = title
        self.youtuberName = youtuberName
        self.rewardAmount = rewardAmount
        self.currentNumberOfReviewers = currentNumberOfReviewers
        self.targetNumberOfReviewers = targetNumberOfReviewers
        self.reviewStartDate = reviewStartDate
        self.reviewEndDate = reviewEndDate
        self.videoDescription = videoDescription
        self.imagePath = imagePath
        self.videoPath = videoPath
        self.didReviewed = didReviewed
        self.category = category
    }
}
