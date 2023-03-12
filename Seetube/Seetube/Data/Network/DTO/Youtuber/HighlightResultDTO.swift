//
//  HighlightResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct HighlightSceneDTO: Decodable {
    let thumbnailImageURL: String
    let startTimeInOriginalVideo: Int
    let endTimeInOriginalVideo: Int
    let startTimeInHighlight: Int
    let endTimeInHighlight: Int
    let endTime: Int
    let totalNumberOfReviewers: Int
    let numberOfReviewersConcentrated: Int
    let numberOfReviewersFelt: Int
    let emotionType: Emotion
}

struct HighlightResultDTO: Decodable, DomainConvertible {
    let highlightVideoURL: String
    let scenes: [HighlightSceneDTO]
    
    func toDomain() -> HighlightResult {
        return HighlightResult()
    }
}
