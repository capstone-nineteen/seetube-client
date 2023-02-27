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
            // TODO: userType 전달
        }
    }
}
