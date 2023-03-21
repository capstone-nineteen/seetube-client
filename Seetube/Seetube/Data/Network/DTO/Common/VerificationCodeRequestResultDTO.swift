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
        if let authNumber = self.authNumber { return .success(authNumber) }
        
        if message == "A user with this email already exists." {
            return .failure(.alreadyExist)
        } else if message == "Please enter a valid email." {
            return .failure(.invalidFormat)
        } else {
            return .failure(.unknown)
        }
    }
}
