//
//  LoginPushable.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/26.
//

import Foundation

protocol LoginPushable: ViewControllerPushable {
    func pushLogin(userType: UserType)
}

extension LoginPushable {
    func pushLogin(userType: UserType) {
        self.push(
            viewControllerType: LoginViewController.self
        ) { viewController in
            let viewModel = LoginViewModel(userType: userType)
            viewController.viewModel = viewModel
        }
    }
}
