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
    private let validateUseCase: ValidateSignUpInfoUseCase
    
    init(
         userType: UserType,
         requestVerificationCodeUseCase: RequestVerificationCodeUseCase,
         signUpUseCase: SignUpUseCase,
         validateUseCase: ValidateSignUpInfoUseCase
    ) {
        self.userType = userType
        self.requestVerificationCodeUseCase = requestVerificationCodeUseCase
        self.signUpUseCase = signUpUseCase
        self.validateUseCase = validateUseCase
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
