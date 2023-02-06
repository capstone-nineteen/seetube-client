//
//  ShortsResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct ShortsSceneDTO: Decodable {
    let videoURL: String
    let startTime: Int
    let endTime: Int
    let concentrationPercentage: Int
    let emotionType: Emotion
    let emotionPerentage: Int
}

struct ShortsResultDTO: Decodable {
    let scenes: [ShortsSceneDTO]
}
