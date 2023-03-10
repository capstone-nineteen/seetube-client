//
//  VideoCardItemViewModel.swift
//  Seetube
//
//  Created by μ΅μμ  on 2023/03/05.
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
        self.remainingPeriod = "π λ¨μ κΈ°κ° \(videoInfo.reviewEndDate.dday())μΌ"
        self.progress = "π€ \(videoInfo.currentNumberOfReviewers)/\(videoInfo.targetNumberOfReviewers)λͺ"
        self.thumbnailUrl = videoInfo.imagePath
    }
}
