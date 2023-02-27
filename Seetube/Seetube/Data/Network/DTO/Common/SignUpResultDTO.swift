//
//  SignUpResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation

struct SignUpResultDTO: Decodable, DomainConvertible {
    let message: String
    let status: Int
    
    func toDomain() -> SignUpResult {
        SignUpResult(message: self.message,
                     status: self.status)
    }
}
