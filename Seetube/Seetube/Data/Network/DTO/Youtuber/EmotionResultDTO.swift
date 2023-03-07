//
//  EmotionResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct EmotionSceneDTO: Decodable, DomainConvertible {
    let thumbnailImageURL: String
    let startTime: Int
    let endTime: Int
    let totalNumberOfReviewers: Int
    let numberOfReviewersFelt: Int
    let emotionType: Emotion
    
    func toDomain() -> EmotionScene {
        return EmotionScene(thumbnailImageURL: self.thumbnailImageURL,
                            startTime: self.startTime,
                            endTime: self.endTime,
                            totalNumberOfReviewers: self.totalNumberOfReviewers,
                            numberOfReviewersFelt: self.numberOfReviewersFelt,
                            emotionType: self.emotionType)
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
