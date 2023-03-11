//
//  DefaultFetchSceneStealerResult.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/11.
//

import Foundation
import RxSwift

class DefaultFetchSceneStealerResultUseCase: FetchSceneStealerResultUseCase {
    private let repository: SceneStealerResultRepository
    
    init(repository: SceneStealerResultRepository) {
        self.repository = repository
    }
    
    func execute(videoId: Int) -> Observable<SceneStealerResult?> {
        return self.repository.getSceneStealerResult()
    }
}
