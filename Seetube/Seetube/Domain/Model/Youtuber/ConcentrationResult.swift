//
//  ConcentrationResult.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

struct ConcentrationScene: Decodable {
    let thumbnailImageURL: String
    let startTime: Float
    let endTime: Float
    let totalNumberOfReviewers: Int
    let numberOfReviewersConcentrated: Int
}

struct ConcentrationResult {
    let originalVideoURL: String
    let scenes: [ConcentrationScene]
}
