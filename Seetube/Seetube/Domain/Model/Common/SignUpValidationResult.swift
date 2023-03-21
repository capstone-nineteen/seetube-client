//
//  SignUpValidationResult.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation

enum SignUpValidationError: Error {
    case tooShort
    case containsCharactersThatAreNotAllowed
    case incorrectFormat
    case mismatch
    case empty
    case unknown
}

struct SignUpValidationResult {
    let isValid: Bool
    let message: String?
}
