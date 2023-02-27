//
//  SignUpPushable.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/27.
//

import Foundation

protocol SignUpPushable: ViewControllerPushable {
    func pushSignUp(userType: UserType)
}

extension SignUpPushable {
    func pushSignUp(userType: UserType) {
        self.push(
            viewControllerType: SignUpViewController.self
        ) { viewController in
            let repository = DefaultSignUpRepository()
            let requestVerificationCodeUseCase = DefaultRequestVerificationCodeUseCase(repository: repository)
            let signUpUseCase = DefaultSignUpUseCase(repository: repository)
            let viewModel = SignUpViewModel(userType: userType,
                                            requestVerificationCodeUseCase: requestVerificationCodeUseCase,
                                            signUpUseCase: signUpUseCase)
            viewController.viewModel = viewModel
        }
    }
}
