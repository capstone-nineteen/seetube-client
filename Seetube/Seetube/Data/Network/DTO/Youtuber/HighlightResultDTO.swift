//
//  HighlightResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct HighlightSceneDTO: Decodable, DomainConvertible {
    let thumbnailImageURL: String
    let startTimeInOriginalVideo: Int
    let endTimeInOriginalVideo: Int
    let startTimeInHighlight: Int
    let endTimeInHighlight: Int
    let totalNumberOfReviewers: Int
    let numberOfReviewersConcentrated: Int
    let numberOfReviewersFelt: Int
    let emotionType: Emotion
    
    func toDomain() -> HighlightScene {
        return HighlightScene(thumbnailImageURL: self.thumbnailImageURL,
                                    startTimeInOriginalVideo: self.startTimeInOriginalVideo,
                                    endTimeInOriginalVideo: self.endTimeInOriginalVideo,
                                    startTimeInHighlight: self.startTimeInHighlight,
                                    endTimeInHighlight: self.endTimeInHighlight,
                                    totalNumberOfReviewers: self.totalNumberOfReviewers,
                                    numberOfReviewersConcentrated: self.numberOfReviewersConcentrated,
                                    numberOfReviewersFelt: self.numberOfReviewersFelt,
                                    emotionType: self.emotionType)
    }
}

struct HighlightResultDTO: Decodable, DomainConvertible {
    let highlightVideoURL: String
    let scenes: [HighlightSceneDTO]
    
    func toDomain() -> HighlightResult {
        return HighlightResult(highlightVideoURL: self.highlightVideoURL,
                               scenes: self.scenes.map { $0.toDomain() })
    }
}
