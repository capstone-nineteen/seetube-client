//
//  ValidateSignUpInfoUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation

protocol ValidateSignUpInfoUseCase {
    func execute(nickname: String) -> Result<Void, SignUpValidationError>
    func execute(email: String) -> Result<Void, SignUpValidationError>
    func execute(userEnteredVerificationCode: String, actualVerificationCode: Int) -> Result<Void, SignUpValidationError>
    func execute(password: String) -> Result<Void, SignUpValidationError>
    func execute(passwordConfirm: String, password: String) -> Result<Void, SignUpValidationError>
}
