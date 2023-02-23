//
//  ReviewData.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/22.
//

import Foundation
import SeeSo

struct RawReview {
    let playTime: Int
    let videoRect: VideoRect
    let gaze: GazeInfo
    let prediction: FaceExpressionPredictor.Prediction?
}
