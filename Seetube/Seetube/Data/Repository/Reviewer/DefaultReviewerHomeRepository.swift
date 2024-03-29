//
//  DefaultReviewerHomeRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

class DefaultReviewerHomeRepository: ReviewerHomeRepository, NetworkRequestable {
    func getReviewerHome() -> Single<ReviewerHome> {
        let endpoint = APIEndpointFactory.makeEndpoint(for: .getReviewerHome)
        return self.getResource(endpoint: endpoint,
                                decodingType: ReviewerHomeDTO.self)
    }
    
    func getVideos(searchKeyword: String) -> Single<VideoList> {
        let endpoint = APIEndpointFactory.makeEndpoint(
            for: .getVideosBySearchKeyword(keyword: searchKeyword)
        )
        return self.getResource(endpoint: endpoint,
                                decodingType: VideoListDTO.self)
    }
}
