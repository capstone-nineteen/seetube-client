//
//  SceneItemViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/06.
//

import Foundation

class SceneItemViewModel {
    let thumbnailUrl: String
    let interval: String
    let description: String
    let progress: Double
    let progressDescription: String
    
    init(
        thumbnailUrl: String,
        interval: String,
        description: String,
        progress: Double,
        progressDescription: String
    ) {
        self.thumbnailUrl = thumbnailUrl
        self.interval = interval
        self.description = description
        self.progress = progress
        self.progressDescription = progressDescription
    }
    
    convenience init(with scene: ConcentrationScene) {
        let startTimeString = StringFormattingHelper.toTimeFormatString(seconds: scene.startTime)
        let endTimeString = StringFormattingHelper.toTimeFormatString(seconds: scene.endTime)
        let interval = startTimeString + " - " + endTimeString
        
        let description = "총 \(scene.totalNumberOfReviewers)명 중에\n\(scene.numberOfReviewersConcentrated)명이 집중했습니다."
        
        let total = Double(scene.totalNumberOfReviewers)
        let concentrated = Double(scene.numberOfReviewersConcentrated)
        let progress = concentrated / total
        let progressDescription = "\(Int(progress * 100))%"
        
        self.init(thumbnailUrl: scene.thumbnailImageURL,
                  interval: interval,
                  description: description,
                  progress: progress,
                  progressDescription: progressDescription)
    }
}
