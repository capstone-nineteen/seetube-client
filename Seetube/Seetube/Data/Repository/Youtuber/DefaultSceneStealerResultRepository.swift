//
//  DefaultSceneStealerResultRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

class DefaultSceneStealerResultRepository: SceneStealerResultRepository, NetworkRequestable {
    func getSceneStealerResult(videoId: Int) -> Single<SceneStealerResult> {
        let endpoint = APIEndpointFactory.makeEndpoint(for: .getSceneStealerResult(videoId: videoId))
        return self.getResource(endpoint: endpoint,
                                decodingType: SceneStealerResultDTO.self)
    }
}
