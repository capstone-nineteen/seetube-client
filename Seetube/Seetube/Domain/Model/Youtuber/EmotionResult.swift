//
//  EmotionResult.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

struct EmotionScene {
    let thumbnailImageURL: String
    let startTime: Int
    let endTime: Int
    let totalNumberOfReviewers: Int
    let numberOfReviewersFelt: Int
    let emotionType: Emotion
}

struct EmotionResult {
    let originalVideoUrl: String
    let scenes: [EmotionScene]
}
