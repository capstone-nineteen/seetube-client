//
//  SceneStealerResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct SceneStealerSceneDTO: Decodable, DomainConvertible {
    let thumbnailURL: String
    let startTime: Int
    let endTime: Int
    let percentageOfConcentration: Int
    
    func toDomain() -> SceneStealerScene {
        return SceneStealerScene(imageURL: self.thumbnailURL,
                                 startTime: self.startTime,
                                 endTime: self.endTime,
                                 percentageOfConcentration: self.percentageOfConcentration)
    }
}

struct SceneStealerResultDTO: Decodable, DomainConvertible {
    let sceneStealer: [SceneStealerSceneDTO]
    
    func toDomain() -> SceneStealerResult {
        return SceneStealerResult(scenes: self.sceneStealer.map { $0.toDomain() })
    }
}
