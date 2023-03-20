//
//  DefaultReviewRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/23.
//

import Foundation
import RxSwift

class DefaultReviewRepository: ReviewRepository, NetworkRequestable {
    func submitReview(reviews: Reviews) -> Single<ReviewSubmissionResult> {
        let reviewsDTO = reviews.toDTO()
        let endpoint = APIEndpointFactory.makeEndpoint(
            for: .submitReview(videoId: reviews.videoId,
                               reviews: reviewsDTO)
        )
        return self.getResource(endpoint: endpoint,
                                decodingType: ReviewSubmissionResultDTO.self)
    }
}
