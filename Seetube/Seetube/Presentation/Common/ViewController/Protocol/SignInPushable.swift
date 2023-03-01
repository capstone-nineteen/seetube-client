//
//  SignInPushable.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/26.
//

import Foundation

protocol SignInPushable: ViewControllerPushable {
    func pushSignIn(userType: UserType)
}

extension SignInPushable {
    func pushSignIn(userType: UserType) {
        self.push(
            viewControllerType: SignInViewController.self
        ) { viewController in
            let repository = DefaultSignInRepository()
            let signInUseCase = DefaultSignInUseCase(repository: repository)
            let viewModel = SignInViewModel(userType: userType,
                                            signInUseCase: signInUseCase)
            viewController.viewModel = viewModel
        }
    }
}
