//
//  ValidateSignUpInfoUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation

protocol ValidateSignUpInfoUseCase {
    func execute(nickname: String) -> SignUpValidationError?
    func execute(email: String) -> SignUpValidationError?
    func execute(userEnteredVerificationCode: String, actualVerificationCode: Int) -> SignUpValidationError?
    func execute(password: String) -> SignUpValidationError?
    func execute(passwordConfirm: String, password: String) -> SignUpValidationError?
}
