//
//  ReviewerHomeVideoItemViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/14.
//

import Foundation

class ReviewerVideoCardItemViewModel: VideoCardItemViewModel {
    let rewardAmount: String
    
    override init(with videoInfo: VideoInfo) {
        self.rewardAmount = "\(videoInfo.rewardAmount)"
        super.init(with: videoInfo)
    }
}
