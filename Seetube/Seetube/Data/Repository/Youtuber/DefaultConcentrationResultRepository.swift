//
//  DefaultConcentrationResultRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

class DefaultConcentrationResultRepository: ConcentrationResultRepository, NetworkRequestable {
    func getConcentrationResult(videoId: Int) -> Single<ConcentrationResult> {
        let endpoint = APIEndpointFactory.makeEndpoint(for: .getConcentrationResult(videoId: videoId))
        return self.getResource(endpoint: endpoint,
                                decodingType: ConcentrationResultDTO.self)
    }
}
