//
//  ConcentrationSceneItemViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/06.
//

import Foundation

class ConcentrationSceneItemViewModel {
    let thumbnailUrl: String
    let interval: String
    let description: String
    let progress: Int
    
    init(with scene: ConcentrationScene) {
        self.thumbnailUrl = scene.thumbnailImageURL
        
        let startTimeString = StringFormattingHelper.toTimeFormatString(seconds: scene.startTime)
        let endTimeString = StringFormattingHelper.toTimeFormatString(seconds: scene.endTime)
        self.interval = startTimeString + " - " + endTimeString
        
        self.description = "총 \(scene.totalNumberOfReviewers)명 중에\n\(scene.numberOfReviewersConcentrated)명이 집중했습니다."
        
        let total = Float(scene.totalNumberOfReviewers)
        let concentrated = Float(scene.numberOfReviewersConcentrated)
        self.progress = Int(concentrated / total * 100)
    }
}
