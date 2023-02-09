//
//  HighlightResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct HighlightSceneDTO: Decodable {
    let thumbnailImageURL: String
    let startTime: Int
    let endTime: Int
    let totalNumberOfReviewers: Int
    let numberOfReviewersConcentrated: Int
    let numberOfReviewersFelt: Int
    let emotionType: Emotion
}

struct HighlightResultDTO: Decodable {
    let scenes: [HighlightSceneDTO]
}
 
extension HighlightResultDTO: DomainConvertible {
    func toDomain() -> HighlightResult {
        return HighlightResult()
    }
}
