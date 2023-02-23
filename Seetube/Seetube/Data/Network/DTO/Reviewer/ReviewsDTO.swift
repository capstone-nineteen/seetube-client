//
//  ReviewsDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/23.
//

import Foundation

struct GazeDataDTO: Encodable {
    let x: Double
    let y: Double
    let trackingState: String
    let eyeMovementState: String
    let screenState: String
}

struct EmotionDataDTO: Encodable {
    let emotionPredictionState: String
    let classification: String
    let confidencePercentage: Double
}

struct ReviewDTO: Encodable {
    let playTime: Int
    let gazeInfo: GazeDataDTO
    let emotionInfo: EmotionDataDTO
}

struct ReviewsDTO: Encodable {
    let watchingInfos: [ReviewDTO]
}
