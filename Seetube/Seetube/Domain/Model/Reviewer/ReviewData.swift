//
//  ReviewData.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/22.
//

import Foundation
import SeeSo

struct ReviewData {
    let playTime: Int
    let gaze: GazeInfo
    let prediction: FaceExpressionPredictor.Prediction?
}
