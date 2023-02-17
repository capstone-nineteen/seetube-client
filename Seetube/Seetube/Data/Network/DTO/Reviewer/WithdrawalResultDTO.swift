//
//  WithdrawResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/17.
//

import Foundation

struct WithdrawalResultDTO: Decodable, DomainConvertible {
    let message: String
    let status: Int
    
    func toDomain() -> WithdrawalResult {
        return WithdrawalResult(message: self.message,
                              didSucceed: self.status == 201)
    }
}
