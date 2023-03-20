//
//  DefaultFetchEmotionResultUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/07.
//

import Foundation
import RxSwift

class DefaultFetchEmotionResultUseCase: FetchEmotionResultUseCase {
    let repository: EmotionResultRepository
    
    init(repository: EmotionResultRepository) {
        self.repository = repository
    }
    
    func execute(videoId: Int) -> Single<EmotionResult> {
        return self.repository.getEmotionResult()
    }
}
