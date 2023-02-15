//
//  DefaultSearchUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/14.
//

import Foundation
import RxSwift

class DefaultSearchUseCase: SearchUseCase {
    private let repository: ReviewerHomeRepository
    
    init(repository: ReviewerHomeRepository) {
        self.repository = repository
    }
    
    func execute(searchKeyword: String) -> Observable<VideoList?> {
        return self.repository.getVideos(searchKeyword: searchKeyword)
    }
}
