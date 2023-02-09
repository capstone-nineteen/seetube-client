//
//  DefaultVideosByCategoryRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

class DefaultVideosByCategoryRepository: VideosByCategoryRepository, NetworkRequestable {
    func getVideosByCategory() -> RxSwift.Observable<VideoList> {
        let endpoint = APIEndpointFactory.makeEndpoint(for: .getVideosByCategory)
        return self.getResource(endpoint: endpoint,
                                decodingType: VideoListDTO.self)
    }
}

