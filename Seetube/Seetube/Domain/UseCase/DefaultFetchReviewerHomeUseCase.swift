//
//  DefaultFetchReviewerHomeUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/10.
//

import Foundation
import RxSwift

class DefaultFetchReviewerHomeUseCase: FetchReviewerHomeUseCase {
    private let repository: ReviewerHomeRepository
    
    init(repository: ReviewerHomeRepository) {
        self.repository = repository
    }
    
    func execute() -> Observable<ReviewerHome?> {
        return self.repository.getReviewerHome()
    }
}
