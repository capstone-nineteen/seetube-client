//
//  SignInResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/01.
//

import Foundation

struct SignInResultDTO: Decodable, DomainConvertible {
    let message: String
    let status: Int
    
    func toDomain() -> SignInResult {
        SignInResult(message: self.message,
                     status: self.status)
    }
}
