//
//  DefaultShortsResultRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

class DefaultShortsResultRepository: ShortsResultRepository, NetworkRequestable {
    func getShortsResult() -> Observable<ShortsResult?> {
        let endpoint = APIEndpointFactory.makeEndpoint(for: .getShortsResult)
        return self.getResource(endpoint: endpoint,
                                decodingType: ShortsResultDTO.self)
    }
}
