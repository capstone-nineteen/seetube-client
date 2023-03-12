//
//  HighlightResult.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

struct HighlightScene {
    let thumbnailImageURL: String
    let startTimeInOriginalVideo: Int
    let endTimeInOriginalVideo: Int
    let startTimeInHighlight: Int
    let endTimeInHighlight: Int
    let totalNumberOfReviewers: Int
    let numberOfReviewersConcentrated: Int
    let numberOfReviewersFelt: Int
    let emotionType: Emotion
}

struct HighlightResult {
    let highlightVideoURL: String
    let scenes: [HighlightScene]
}
