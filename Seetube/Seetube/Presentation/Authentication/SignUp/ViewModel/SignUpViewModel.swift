//
//  SignUpViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation

class SignUpViewModel: ViewModelType {
    private var userType: UserType
    private let requestVerificationCodeUseCase: RequestVerificationCodeUseCase
    private let signUpUseCase: SignUpUseCase
    
    init(
         userType: UserType,
         requestVerificationCodeUseCase: RequestVerificationCodeUseCase,
         signUpUseCase: SignUpUseCase
    ) {
        self.userType = userType
        self.requestVerificationCodeUseCase = requestVerificationCodeUseCase
        self.signUpUseCase = signUpUseCase
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}

extension SignUpViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
}
