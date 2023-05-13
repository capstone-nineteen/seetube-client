//
//  EmotionResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct EmotionSceneDTO: Decodable, DomainConvertible {
    let thumbnailURL: String
    let emotionStartTime: Float
    let emotionEndTime: Float
    let totalNumberOfReviewers: Int
    let numberOfReviewersFelt: Int
    let emotion: Emotion
    
    func toDomain() -> EmotionScene {
        return EmotionScene(thumbnailImageURL: self.thumbnailURL,
                            startTime: self.emotionStartTime,
                            endTime: self.emotionEndTime,
                            totalNumberOfReviewers: self.totalNumberOfReviewers,
                            numberOfReviewersFelt: self.numberOfReviewersFelt,
                            emotionType: self.emotion)
    }
}

struct EmotionResultDTO: Decodable, DomainConvertible {
    let originalVideoURL: String
    let scenes: [EmotionSceneDTO]
    
    func toDomain() -> EmotionResult {
        return EmotionResult(originalVideoURL: self.originalVideoURL,
                             scenes: self.scenes.map { $0.toDomain() })
    }
}
