//
//  EmotionResult.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

struct EmotionScene {
    let thumbnailImageURL: String
    let startTime: Float
    let endTime: Float
    let totalNumberOfReviewers: Int
    let numberOfReviewersFelt: Int
    let emotionType: Emotion
}

struct EmotionResult {
    let originalVideoURL: String
    let scenes: [EmotionScene]
}
