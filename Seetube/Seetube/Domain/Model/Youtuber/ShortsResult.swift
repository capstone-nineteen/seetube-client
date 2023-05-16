//
//  ShortsResult.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

struct ShortsScene {
    let thumbnailURL: String
    let videoURL: String
    let startTime: Float
    let endTime: Float
    let concentrationPercentage: Int
}

struct ShortsResult {
    let scenes: [ShortsScene]
}
