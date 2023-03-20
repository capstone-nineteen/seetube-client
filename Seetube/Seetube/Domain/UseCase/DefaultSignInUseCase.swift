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
            .do(onNext: {
                // TODO: repository에 saveToken 메소드로 분리
                guard let token = $0?.token else { return }
                KeychainHelper.standard.accessToken = token
                UserDefaultHelper.shared.userType = userType
            })
            .map { $0 != nil }
    }
}
