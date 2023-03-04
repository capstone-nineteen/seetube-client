//
//  YoutuberFinishedVideoCardItemViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/05.
//

import Foundation

class YoutuberFinishedVideoCardItemViewModel {
    let title: String
    let youtuberName: String
    let period: String
    let numberOfReviewers: String
    
    init(with videoInfo: VideoInfo) {
        self.title = videoInfo.title
        self.youtuberName = videoInfo.youtuberName
        self.period = "🕔 \(videoInfo.reviewStartDate.toyyMMddStyleWithDot())-\(videoInfo.reviewEndDate.toyyMMddStyleWithDot())"
        self.numberOfReviewers = "👤 \(videoInfo.targetNumberOfReviewers)명"
    }
}
