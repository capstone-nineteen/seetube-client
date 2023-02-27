//
//  ValidateSignUpInfoUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation

protocol ValidateSignUpInfoUseCase {
    func execute(nickname: String) -> Bool
    func execute(email: String) -> Bool
    func execute(userEnteredVerificationCode: String, actualVerificationCode: Int) -> Bool
    func execute(password: String) -> Bool
    func execute(passwordConfirm: String, password: String) -> Bool
}
