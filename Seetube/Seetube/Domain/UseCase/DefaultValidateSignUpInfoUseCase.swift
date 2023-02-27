//
//  DefaultValidateSignUpInfoUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation

class DefaultValidateSignUpInfoUseCase: ValidateSignUpInfoUseCase {
    func execute(nickname: String) -> Bool {
        return nickname.count > 2
    }
    
    func execute(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func execute(userEnteredVerificationCode: String, actualVerificationCode: Int) -> Bool {
        return userEnteredVerificationCode == "\(actualVerificationCode)"
    }
    
    func execute(password: String) -> Bool {
        let passwordRegex = "^[a-zA-Z!@#$%^&*()_+\\-={}|\\[\\]\\;:'\",.<>/?`~\\\\]+$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", password)
        return passwordPredicate.evaluate(with: password) && password.count >= 10
    }
    
    func execute(passwordConfirm: String, password: String) -> Bool {
        return passwordConfirm == password
    }
}
