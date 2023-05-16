//
//  ShortsItemViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/14.
//

import Foundation

class ShortsItemViewModel {
    let shouldDisplayCheckIcon: Bool
    let isPlaying: Bool
    let thumbnailURL: String
    let interval: String
    let description: String
    
    init(
        with scene: ShortsScene,
        shouldDisplayCheckIcon: Bool,
        isPlaying: Bool
    ) {
        self.shouldDisplayCheckIcon = shouldDisplayCheckIcon
        self.isPlaying = isPlaying
        self.thumbnailURL = scene.thumbnailURL
        self.interval = "🕔 " + StringFormattingHelper.toTimeIntervalFormatString(startSecond: Int(scene.startTime),
                                                                                  endSecond: Int(scene.endTime))
        self.description = "집중도 \(scene.concentrationPercentage)%"
    }
}
