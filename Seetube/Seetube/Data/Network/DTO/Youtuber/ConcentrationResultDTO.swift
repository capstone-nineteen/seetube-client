//
//  ConcentrationResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct ConcentrationSceneDTO: Decodable {
    let thumbnailImageURL: String
    let startTime: Int
    let endTime: Int
    let totalNumberOfReviewers: Int
    let numberOfReviewersConcentrated: Int
}

struct ConcentrationResultDTO: Decodable {
    let originalVideoURL: String
    let scenes: [ConcentrationSceneDTO]
}
