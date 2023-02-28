//
//  DefaultValidateSignUpInfoUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation

class DefaultValidateSignUpInfoUseCase: ValidateSignUpInfoUseCase {
    func execute(nickname: String) -> SignUpValidationError? {
        if nickname.count < 2 {
            return .tooShort
        }
        
        return nil
    }
    
    func execute(email: String) -> SignUpValidationError? {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        if !emailPredicate.evaluate(with: email) {
            return .incorrectFormat
        }
        
        return nil
    }
    
    func execute(userEnteredVerificationCode: String, actualVerificationCode: Int) -> SignUpValidationError? {
        if userEnteredVerificationCode != "\(actualVerificationCode)" {
            return .mismatch
        }
        
        return nil
    }
    
    func execute(password: String) -> SignUpValidationError? {
        let passwordRegex = "^[a-zA-Z!@#$%^&*()_+\\-={}|\\[\\]\\;:'\",.<>/?`~\\\\]+$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", password)
        if !passwordPredicate.evaluate(with: password) {
            return .containsCharactersThatAreNotAllowed
        }
        
        if password.count < 10 {
            return .tooShort
        }
        
        return nil
    }
    
    func execute(passwordConfirm: String, password: String) -> SignUpValidationError? {
        if passwordConfirm != password {
            return .mismatch
        }
        
        return nil
    }
}
