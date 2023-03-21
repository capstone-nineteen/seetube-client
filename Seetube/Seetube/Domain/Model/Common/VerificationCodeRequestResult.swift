//
//  VerificationCodeRequestResult.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation

enum VerificationCodeRequestResult {
    enum VerificationCodeRequestError: Error {
        case alreadyExist
        case invalidFormat
        case unknown
    }
    
    case success(Int)
    case failure(VerificationCodeRequestError)
}
