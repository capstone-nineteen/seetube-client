//
//  ConcentrationResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct ConcentrationSceneDTO: Decodable, DomainConvertible {
    let thumbnailImageURL: String?  // FIXME: 백엔드 확인 후 옵셔널 제거
    let focusStartTime: Float
    let focusEndTime: Float
    let totalNumberOfReviewers: Int
    let numberOfReviewersConcentrated: Int
    
    func toDomain() -> ConcentrationScene {
        return ConcentrationScene(thumbnailImageURL: self.thumbnailImageURL ?? "",
                                  startTime: self.focusStartTime,
                                  endTime: self.focusEndTime,
                                  totalNumberOfReviewers: self.totalNumberOfReviewers,
                                  numberOfReviewersConcentrated: self.numberOfReviewersConcentrated)
    }
}

struct ConcentrationResultDTO: Decodable, DomainConvertible {
    let originalVideoURL: String
    let scenes: [ConcentrationSceneDTO]
    
    func toDomain() -> ConcentrationResult {
        return ConcentrationResult(originalVideoURL: self.originalVideoURL,
                                   scenes: self.scenes.map { $0.toDomain() })
    }
}
