//
//  SignInResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/01.
//

import Foundation

struct SignInResultDTO: Decodable, DomainConvertible {
    let token: String
    
    func toDomain() -> SignInResult {
        SignInResult(token: self.token)
    }
}
