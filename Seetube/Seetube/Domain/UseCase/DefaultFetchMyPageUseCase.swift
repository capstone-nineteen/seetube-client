//
//  DefaultFetchMyPageUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

class DefaultFetchMyCaseUseCase: FetchMyPageUseCase {
    private let repository: MyPageRepository
    
    init(repository: MyPageRepository) {
        self.repository = repository
    }
    
    func execute() -> Single<MyPage> {
        return self.repository.getMyPage()
    }
}
