//
//  SceneStealerResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct SceneStealerSceneDTO: Decodable {
    let thumbnailImageURL: String
    let startTime: Int
    let endTime: Int
    let percentageOfConcentration: Int
}

struct SceneStealerResultDTO: Decodable {
    let originalVideoURL: String
    let scenes: [SceneStealerSceneDTO]
}
