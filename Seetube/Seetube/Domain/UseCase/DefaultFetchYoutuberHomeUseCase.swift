//
//  DefaultYoutuberHomeUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/03.
//

import Foundation
import RxSwift

class DefaultFetchYoutuberHomeUseCase: FetchYoutuberHomeUseCase {
    private let repository: YoutuberHomeRepository
    
    init(repository: YoutuberHomeRepository) {
        self.repository = repository
    }
    
    func execute() -> Single<YoutuberHome> {
        return self.repository.getYoutuberHome()
    }
}
