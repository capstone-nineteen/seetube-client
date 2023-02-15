//
//  DefaultFetchVideoInfoUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/15.
//

import Foundation
import RxSwift

class DefaultFetchVideoDetailUseCase: FetchVideoDetailUseCase {
    private let repository: VideoDetailRepository
    
    init(repository: VideoDetailRepository) {
        self.repository = repository
    }
    
    func execute(id: Int) -> Observable<VideoInfo> {
        return self.repository.getVideoInfo(id: id)
    }
}
