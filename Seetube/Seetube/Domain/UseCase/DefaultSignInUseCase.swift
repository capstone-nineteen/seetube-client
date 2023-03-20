//
//  DefaultSignInUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/01.
//

import Foundation
import RxSwift
import KeychainAccess

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
            .asObservable()
            .flatMap { [weak self] signInResult -> Observable<Bool> in
                guard let self = self else { return .error(OptionalError.nilSelf) }
                return self.repository.saveToken(token: signInResult.token, userType: userType)
            }
    }
}
