//
//  SceneStealerResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct SceneStealerSceneDTO: Decodable, DomainConvertible {
    let thumbnailImageURL: String
    let startTime: Int
    let endTime: Int
    let percentageOfConcentration: Int
    
    func toDomain() -> SceneStealerScene {
        return SceneStealerScene(imageURL: self.thumbnailImageURL,
                                 startTime: self.startTime,
                                 endTime: self.endTime,
                                 percentageOfConcentration: self.percentageOfConcentration)
    }
}

struct SceneStealerResultDTO: Decodable, DomainConvertible {
    let scenes: [SceneStealerSceneDTO]
    
    func toDomain() -> SceneStealerResult {
        return SceneStealerResult(scenes: self.scenes.map { $0.toDomain() })
    }
}
