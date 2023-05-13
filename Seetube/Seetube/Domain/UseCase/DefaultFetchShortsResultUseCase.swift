//
//  DefaultFetchShortsResultUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/13.
//

import Foundation
import RxSwift

class DefaultFetchShortsResultUseCase: FetchShortsResultUseCase {
    let repository: ShortsResultRepository
    
    init(repository: ShortsResultRepository) {
        self.repository = repository
    }
    
    func execute(videoId: Int) -> Single<ShortsResult> {
        return self.repository.getShortsResult(videoId: videoId)
    }
}
