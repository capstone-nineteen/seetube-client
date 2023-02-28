//
//  VerificationCodeRequestResult.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation

struct VerificationCodeRequestResult {
    enum VerificationCodeRequestError: Error {
        case alreadyExist
        case invalidFormat
    }
    
    let verificationCode: Int?
    let error: VerificationCodeRequestError?
}
