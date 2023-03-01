//
//  SignInViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/26.
//

import Foundation
import RxSwift
import RxCocoa

class SignInViewModel: ViewModelType {
    private let userType: UserType
    
    init(userType: UserType) {
        self.userType = userType
    }
    
    func transform(input: Input) -> Output {
        let shouldMoveToSignUp = input.signUpButtonTouched
            .map { [weak self] _ in
                return self?.userType
            }
            .compactMap { $0 }
        
        return Output(shouldMoveToSignUp: shouldMoveToSignUp)
    }
}

extension SignInViewModel {
    struct Input {
        let signUpButtonTouched: Driver<Void>
    }
    
    struct Output {
        let shouldMoveToSignUp: Driver<UserType>
    }
}
