//
//  DefaultYoutuberHomeUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/03.
//

import Foundation
import RxSwift

class DefaultYoutuberHomeUseCase: FetchYoutuberHomeUseCase {
    private let repository: YoutuberHomeRepository
    
    init(repository: YoutuberHomeRepository) {
        self.repository = repository
    }
    
    func execute() -> Observable<YoutuberHome?> {
        return self.repository.getYoutuberHome()
    }
}
