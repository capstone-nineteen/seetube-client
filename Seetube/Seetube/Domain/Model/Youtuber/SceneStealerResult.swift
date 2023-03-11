//
//  SceneStealerResult.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

struct SceneStealerScene {
    let imageURL: String
    let startTime: Int
    let endTime: Int
    let percentageOfConcentration: Int
}

struct SceneStealerResult {
    let scenes: [SceneStealerScene]
}
