//
//  SceneLargeItemViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/12.
//

import Foundation

class SceneLargeItemViewModel {
    let thumbnailUrl: String
    let interval: String
    let description: String
    
    init(
        thumbnailUrl: String,
        interval: String,
        description: String
    ) {
        self.thumbnailUrl = thumbnailUrl
        self.interval = interval
        self.description = description
    }
    
    convenience init(with scene: HighlightScene) {
        let interval = StringFormattingHelper.toTimeIntervalFormatString(startSecond: scene.startTimeInOriginalVideo,
                                                                         endSecond: scene.endTimeInOriginalVideo)
        let description = "총 \(scene.totalNumberOfReviewers)명 중에\n\(scene.numberOfReviewersConcentrated)명이 집중했고,\n\(scene.numberOfReviewersFelt)명이 \(scene.emotionType.korDescription)을(를) 느꼈습니다."
        
        self.init(thumbnailUrl: scene.thumbnailImageURL,
                  interval: interval,
                  description: description)
    }
}
