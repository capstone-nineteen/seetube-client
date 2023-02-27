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
        VerificationCodeRequestResult(verificationCode: self.authNumber,
                                      message: self.message)
    }
}
