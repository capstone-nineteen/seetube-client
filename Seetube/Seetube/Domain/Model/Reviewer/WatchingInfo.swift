//
//  WatchingInfo.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/23.
//

import Foundation
import SeeSo

struct NormalizedGazeInfo {
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
}

struct EmotionInfo {
    enum EmotionPredictionState: String {
        case success
        case failure
    }
    
    let emotionPredictionState: EmotionPredictionState
    let classification: Emotion?
    let confidence: Double?
    
    init(prediction: FaceExpressionPredictor.Prediction?) {
        self.emotionPredictionState = (prediction == nil) ? .failure : .success
        self.classification = prediction?.classification
        self.confidence = prediction?.confidencePercentage
    }
}

struct WatchingInfo {
    let playTime: Int
    let gazeInfo: NormalizedGazeInfo
    let emotionInfo: EmotionInfo
    
    init(reviewData: ReviewData) {
        self.playTime = reviewData.playTime
        self.gazeInfo = NormalizedGazeInfo(gazeInfo: reviewData.gaze,
                                           videoRect: reviewData.videoRect)
        self.emotionInfo = EmotionInfo(prediction: reviewData.prediction)
    }
}
