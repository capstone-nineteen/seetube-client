//
//  SubmitReviewUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/23.
//

import Foundation
import RxSwift

protocol SubmitReviewUseCase {
    func execute(reviews: Reviews) -> Completable
}
