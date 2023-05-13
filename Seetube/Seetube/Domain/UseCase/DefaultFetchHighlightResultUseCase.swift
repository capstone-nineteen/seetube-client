//
//  DefaultFetchHighlightResultUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/12.
//

import Foundation
import RxSwift

class DefaultFetchHighlightResultUseCase: FetchHighlightResultUseCase {
    private let repository: HighlightResultRepository
    
    init(repository: HighlightResultRepository) {
        self.repository = repository
    }
    
    func execute(videoId: Int) -> Single<HighlightResult> {
        return self.repository.getHighlightResult(videoId: videoId)
    }
}
