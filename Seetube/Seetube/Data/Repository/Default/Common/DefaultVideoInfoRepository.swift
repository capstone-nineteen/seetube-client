//
//  DefaultVideoInfoRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

class DefaultVideoInfoRepository: VideoInfoRepository, NetworkRequestable {
    func getVideoInfo() -> Observable<VideoInfo> {
        let endpoint = APIEndpointFactory.makeEndpoint(for: .getVideoInfo)
        return self.getResource(endpoint: endpoint,
                                decodingType: VideoInfoDTO.self)
    }
}
