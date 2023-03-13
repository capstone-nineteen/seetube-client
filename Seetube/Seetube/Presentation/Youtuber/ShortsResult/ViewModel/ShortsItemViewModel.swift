//
//  ShortsItemViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/14.
//

import Foundation

class ShortsItemViewModel {
    let shouldDisplayCheckIcon: Bool
    let thumbnailURL: String
    let interval: String
    let description: String
    
    init(with scene: ShortsScene, shouldDisplayCheckIcon: Bool) {
        self.shouldDisplayCheckIcon = shouldDisplayCheckIcon
        self.thumbnailURL = scene.thumbnailURL
        self.interval = "🕔 " + StringFormattingHelper.toTimeIntervalFormatString(startSecond: scene.startTime,
                                                                                  endSecond: scene.endTime)
        self.description = "집중도 \(scene.concentrationPercentage)%\n\(scene.emotionType.korDescription) \(scene.emotionPerentage)%"
    }
}
