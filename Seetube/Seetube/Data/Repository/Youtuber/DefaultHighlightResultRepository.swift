//
//  DefaultHighlightResultRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

class DefaultHighlightResultRepository: HighlightResultRepository, NetworkRequestable {
    func getHighlightResult() -> Single<HighlightResult> {
        let endpoint = APIEndpointFactory.makeEndpoint(for: .getHighlightResult)
        return self.getResource(endpoint: endpoint,
                                decodingType: HighlightResultDTO.self)
    }
}
