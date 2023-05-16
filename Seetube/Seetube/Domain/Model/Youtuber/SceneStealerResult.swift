//
//  SceneStealerResult.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

struct SceneStealerScene {
    let imageURL: String
    let startTime: Float
    let endTime: Float
    let percentageOfConcentration: Int
}

struct SceneStealerResult {
    let scenes: [SceneStealerScene]
}
