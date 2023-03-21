//
//  DefaultValidateSignUpInfoUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation

class DefaultValidateSignUpInfoUseCase: ValidateSignUpInfoUseCase {
    func execute(nickname: String) -> Result<Void, SignUpValidationError> {
        if nickname.count == 0 {
            return .failure(SignUpValidationError.empty)
        }
        
        if nickname.count < 2 {
            return .failure(SignUpValidationError.tooShort)
        }
        
        return .success(())
    }
    
    func execute(email: String) -> Result<Void, SignUpValidationError> {
        if email.count == 0 {
            return .failure(SignUpValidationError.empty)
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        if !emailPredicate.evaluate(with: email) {
            return .failure(SignUpValidationError.incorrectFormat)
        }
        
        return .success(())
    }
    
    func execute(userEnteredVerificationCode: String, actualVerificationCode: Int)  -> Result<Void, SignUpValidationError> {
        if userEnteredVerificationCode.count == 0 {
            return .failure(SignUpValidationError.empty)
        }
        
        if userEnteredVerificationCode != "\(actualVerificationCode)" {
            return .failure(SignUpValidationError.mismatch)
        }
        
        return .success(())
    }
    
    func execute(password: String) -> Result<Void, SignUpValidationError> {
        if password.count == 0 {
            return .failure(SignUpValidationError.empty)
        }
        
        let passwordRegex = "^[a-zA-Z0-9!@#$%^&*()_+\\-={}|\\[\\]\\;:'\",.<>/?`~\\\\]+$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        if !passwordPredicate.evaluate(with: password) {
            return .failure(SignUpValidationError.containsCharactersThatAreNotAllowed)
        }
        
        if password.count < 10 {
            return .failure(SignUpValidationError.tooShort)
        }
        
        return .success(())
    }
    
    func execute(passwordConfirm: String, password: String) -> Result<Void, SignUpValidationError> {
        if passwordConfirm.count == 0 {
            return .failure(SignUpValidationError.empty)
        }
        
        if passwordConfirm != password {
            return .failure(SignUpValidationError.mismatch)
        }
        
        return .success(())
    }
}
