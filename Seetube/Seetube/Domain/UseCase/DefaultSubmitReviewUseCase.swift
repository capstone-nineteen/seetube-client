//
//  DefaultSubmitReviewUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/23.
//

import Foundation
import RxSwift

class DefaultSubmitReviewUseCase: SubmitReviewUseCase {
    private let repository: ReviewRepository
    
    init(repository: ReviewRepository) {
        self.repository = repository
    }
    
    func execute(reviews: Reviews) -> Completable {
        return self.repository.submitReview(reviews: reviews)
            .map {
                if $0.status != 201 {
                    throw NetworkServiceError.requestFailed
                } else {
                    return $0
                }
            }
            .asCompletable()
    }
}
