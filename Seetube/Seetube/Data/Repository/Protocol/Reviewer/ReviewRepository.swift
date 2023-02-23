//
//  ReviewRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/23.
//

import Foundation
import RxSwift

protocol ReviewRepository {
    func submitReview(reviews: Reviews) -> Observable<ReviewSubmissionResult?>
}
