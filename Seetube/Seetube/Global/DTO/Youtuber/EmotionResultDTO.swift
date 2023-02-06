//
//  EmotionResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct EmotionSceneDTO: Decodable {
    let thumbnailImageURL: String
    let startTime: Int
    let endTime: Int
    let totalNumberOfReviewers: Int
    let numberOfReviewersFelt: Int
    let emotionType: Emotion
}

struct EmotionResultDTO: Decodable {
    let originalVideoURL: String
    let scenes: [EmotionSceneDTO]
}
