//
//  DefaultSubmitReviewUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/23.
//

import Foundation
import RxSwift

class DefaultSubmitReviewUseCase: SubmitReviewUseCase {
    func execute(review: Review) -> Observable<Bool> {
        return .just(true)
    }
}