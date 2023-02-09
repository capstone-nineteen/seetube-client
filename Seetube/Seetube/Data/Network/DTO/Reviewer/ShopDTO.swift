//
//  ShopDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct ShopDTO: Decodable {
    let totalCoinAmount: Int
}
 
extension ShopDTO: DomainConvertible {
    func toDomain() -> Shop {
        return Shop()
    }
}
