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
    
    func execute(reviews: Reviews) -> Observable<Bool> {
        // TODO: Completable & Error 처리로 리팩토링
        return self.repository.submitReview(reviews: reviews)
            .asObservable()
            .map { $0.status == 200 }
    }
}
