//
//  DefaultYoutuberHomeRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

class DefaultYoutuberHomeRepository: YoutuberHomeRepository, NetworkRequestable {
    func getYoutuberHome() -> Single<YoutuberHome> {
        let endpoint = APIEndpointFactory.makeEndpoint(for: .getYoutuberHome)
        return self.getResource(endpoint: endpoint,
                                decodingType: YoutuberHomeDTO.self)
    }
}
