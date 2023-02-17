//
//  ShopDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct ShopDTO: Decodable, DomainConvertible {
    let reviewerCoin: Int
    
    func toDomain() -> Shop {
        return Shop(totalCoinAmount: self.reviewerCoin)
    }
}
