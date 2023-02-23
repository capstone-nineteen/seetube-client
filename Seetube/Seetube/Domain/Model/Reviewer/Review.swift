//
//  Review.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/23.
//

import Foundation
import SeeSo

struct GazeData: DTOConvertible {
    let x: Double
    let y: Double
    let trackingState: TrackingState
    let eyeMovementState: EyeMovementState
    let screenState: ScreenState
    
    init(gazeInfo: GazeInfo, videoRect: VideoRect) {
        let transformedX = gazeInfo.x - videoRect.x
        let transformedY = gazeInfo.y - videoRect.y
        let normalizedX = transformedX / videoRect.width
        let normalizedY = transformedY / videoRect.height
        
        self.x = normalizedX
        self.y = normalizedY
        self.trackingState = gazeInfo.trackingState
        self.eyeMovementState = gazeInfo.eyeMovementState
        self.screenState = gazeInfo.screenState
    }
    
    func toDTO() -> GazeDataDTO {
        GazeDataDTO(x: self.x,
                    y: self.y,
                    trackingState: self.trackingState.description,
                    eyeMovementState: self.eyeMovementState.description,
                    screenState: self.screenState.description)
    }
}

struct EmotionData: DTOConvertible {
    enum EmotionPredictionState: String {
        case success = "SUCCESS"
        case failure = "FAILURE"
    }
    
    let emotionPredictionState: EmotionPredictionState
    let classification: Emotion?
    let confidence: Double?
    
    init(prediction: FaceExpressionPredictor.Prediction?) {
        self.emotionPredictionState = (prediction == nil) ? .failure : .success
        self.classification = prediction?.classification
        self.confidence = prediction?.confidencePercentage
    }
    
    func toDTO() -> EmotionDataDTO {
        EmotionDataDTO(emotionPredictionState: self.emotionPredictionState.rawValue,
                       classification: self.classification?.rawValue ?? "NAN",
                       confidencePercentage: self.confidence ?? 0)
    }
}

struct Review: DTOConvertible {
    let playTime: Int
    let gazeData: GazeData
    let emotionData: EmotionData
    
    init(rawReview: RawReview) {
        self.playTime = rawReview.playTime
        self.gazeData = GazeData(gazeInfo: rawReview.gaze,
                                 videoRect: rawReview.videoRect)
        self.emotionData = EmotionData(prediction: rawReview.prediction)
    }
    
    func toDTO() -> ReviewDTO {
        return ReviewDTO(playTime: self.playTime,
                               gazeInfo: self.gazeData.toDTO(),
                               emotionInfo: self.emotionData.toDTO())
    }
}

struct Reviews: DTOConvertible {
    let videoId: Int
    let reviews: [Review]
    
    func toDTO() -> ReviewsDTO {
        ReviewsDTO(watchingInfos: self.reviews.map { $0.toDTO() })
    }
}
