//
//  DefaultRequestVerificationCodeUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation
import RxSwift

class DefaultRequestVerificationCodeUseCase: RequestVerificationCodeUseCase {
    private let repository: SignUpRepository
    
    init(repository: SignUpRepository) {
        self.repository = repository
    }
    
    func execute(userType: UserType, email: String) -> Single<VerificationCodeRequestResult> {
        return self.repository
            .requestVerificationCode(userType: userType, email: email)
    }
}
