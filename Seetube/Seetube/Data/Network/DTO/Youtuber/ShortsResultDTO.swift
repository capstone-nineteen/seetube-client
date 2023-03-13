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
    let startTime: Int
    let endTime: Int
    let concentrationPercentage: Int
    let emotionType: Emotion
    let emotionPerentage: Int
    
    func toDomain() -> ShortsScene {
        return ShortsScene(thumbnailURL: self.thumbnailURL,
                           videoURL: self.videoURL,
                           startTime: self.startTime,
                           endTime: self.endTime,
                           concentrationPercentage: self.concentrationPercentage,
                           emotionType: self.emotionType,
                           emotionPerentage: self.emotionPerentage)
    }
}

struct ShortsResultDTO: Decodable, DomainConvertible {
    let scenes: [ShortsSceneDTO]
    
    func toDomain() -> ShortsResult {
        return ShortsResult(scenes: self.scenes.map { $0.toDomain() })
    }
}
