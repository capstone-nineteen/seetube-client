//
//  DefaultSignInUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/01.
//

import Foundation
import RxSwift

class DefaultSignInUseCase: SignInUseCase {
    private let repository: SignInRepository
    
    init(repository: SignInRepository) {
        self.repository = repository
    }
    
    func execute(
        userType: UserType,
        email: String,
        password: String
    ) -> Observable<Bool> {
        return self.repository
            .signIn(userType: userType,
                    email: email,
                    password: password)
            .map { $0?.status == 200 }
    }
}
