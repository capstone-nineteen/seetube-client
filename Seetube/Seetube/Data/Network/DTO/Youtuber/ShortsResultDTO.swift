//
//  ShortsResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct ShortsSceneDTO: Decodable, DomainConvertible {
    let thumbnailURL: String
    let videoURL: String
    let startTime: Float
    let endTime: Float
    let percentageOfConcentration: Int
    
    func toDomain() -> ShortsScene {
        return ShortsScene(thumbnailURL: self.thumbnailURL,
                           videoURL: self.videoURL,
                           startTime: self.startTime,
                           endTime: self.endTime,
                           concentrationPercentage: self.percentageOfConcentration)
    }
}

struct ShortsResultDTO: Decodable, DomainConvertible {
    let shorts: [ShortsSceneDTO]
    
    func toDomain() -> ShortsResult {
        return ShortsResult(scenes: self.shorts.map { $0.toDomain() })
    }
}
