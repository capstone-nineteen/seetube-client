//
//  DefaultEmotionResultRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

class DefaultEmotionResultRepository: EmotionResultRepository, NetworkRequestable {
    func getEmotionResult(videoId: Int) -> Single<EmotionResult> {
        let endpoint = APIEndpointFactory.makeEndpoint(for: .getEmotionResult(videoId: videoId))
        return self.getResource(endpoint: endpoint,
                                decodingType: EmotionResultDTO.self)
    }
}
