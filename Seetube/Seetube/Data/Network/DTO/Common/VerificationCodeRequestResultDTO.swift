//
//  VerificationCodeRequestResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation

struct VerificationCodeRequestResultDTO: Decodable, DomainConvertible {
    let authNumber: Int?
    let message: String?
    let status: Int?
    
    func toDomain() -> VerificationCodeRequestResult {
        var error: VerificationCodeRequestResult.VerificationCodeRequestError? = nil
        
        if message == "A user with this email already exists." {
            error = .alreadyExist
        } else if message == "Please enter a valid email." {
            error = .invalidFormat
        }
        
        return VerificationCodeRequestResult(verificationCode: self.authNumber,
                                             error: error)
    }
}
