//
//  DefaultSignUpUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation
import RxSwift

class DefaultSignUpUseCase: SignUpUseCase {
    private let repository: SignUpRepository
    
    init(repository: SignUpRepository) {
        self.repository = repository
    }
    
    func execute(
        userType: UserType,
        info: SignUpInformation
    ) -> Observable<Bool> {
        return self.repository.signUp(userType: userType, info: info)
            .asObservable()
            .map { $0.status == 200 }
    }
}
