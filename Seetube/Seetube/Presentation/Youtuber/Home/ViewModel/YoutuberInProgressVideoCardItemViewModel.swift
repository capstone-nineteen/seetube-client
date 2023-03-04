//
//  YoutuberInProgressVideoCardItemViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/05.
//

import Foundation

class YoutuberInProgressVideoCardItemViewModel: VideoCardItemViewModel {
    let progressPercentage: String
    
    override init(with videoInfo: VideoInfo) {
        let current = Double(videoInfo.currentNumberOfReviewers)
        let target = Double(videoInfo.targetNumberOfReviewers)
        let percentage = current / target * 100.0
        self.progressPercentage = "\(percentage)%"
        super.init(with: videoInfo)
    }
}
