//
//  DefaultCheckAbusingUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/04/15.
//

import Foundation

class DefaultCheckAbusingUseCase: CheckAbusingUseCase {
    func execute(review: Review) -> Bool {
        let gazeData = review.gazeData
        
        let isFaceDetected = gazeData.trackingState != .FACE_MISSING
        let isGazeWithinScreen = gazeData.screenState == .INSIDE_OF_SCREEN
        
        return !isFaceDetected || !isGazeWithinScreen
    }
}
