//
//  DefaultSignOutUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/20.
//

import Foundation
import RxSwift

class DefaultSignOutUseCase: SignOutUseCase {
    private let repository: SignOutRepository
    
    init(repository: SignOutRepository) {
        self.repository = repository
    }
    
    func execute() -> Completable {
        return self.repository.removeToken()
    }
}
