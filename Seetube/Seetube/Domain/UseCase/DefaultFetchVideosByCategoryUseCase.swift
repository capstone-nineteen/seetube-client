//
//  DefaultFetchVideosByCategoryUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/16.
//

import Foundation
import RxSwift

class DefaultFetchVideosByCategoryUseCase: FetchVideosByCategoryUseCase {
    private let repository: VideosByCategoryRepository
    
    init(repository: VideosByCategoryRepository) {
        self.repository = repository
    }
    
    func execute(category: Category) -> Observable<VideoList> {
        return self.repository.getVideosByCategory(category: category.rawValue)
    }
}
