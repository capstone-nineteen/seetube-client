//
//  DefaultVideoInfoRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

class DefaultVideoDetailRepository: VideoDetailRepository, NetworkRequestable {
    func getVideoInfo(id: Int) -> Single<VideoInfo> {
        let endpoint = APIEndpointFactory.makeEndpoint(for: .getVideoInfo(id: id))
        return self.getResource(endpoint: endpoint,
                                decodingType: VideoDetailDTO.self)
    }
}
