//
//  VideoCardItemViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/05.
//

import Foundation

class VideoCardItemViewModel {
    let title: String
    let youtuberName: String
    let remainingPeriod: String
    let progress: String
    let thumbnailUrl: String
    
    init(with videoInfo: VideoInfo) {
        self.title = videoInfo.title
        self.youtuberName = videoInfo.youtuberName
        self.remainingPeriod = "🕔 남은 기간 \(videoInfo.reviewEndDate.dday())일"
        self.progress = "👤 \(videoInfo.currentNumberOfReviewers)/\(videoInfo.targetNumberOfReviewers)명"
        self.thumbnailUrl = videoInfo.imagePath
    }
}
