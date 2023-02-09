//
//  MyPageDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct CoinHistoryDTO: Decodable {
    let date: Date
    let content: String
    let amount: Int
}

struct MyPageDTO: Decodable {
    let name: String
    let coin: Int
    let withdrawHistories: [CoinHistoryDTO]
    let reviewHistories: [CoinHistoryDTO]
    
    func toDomain() -> MyPage {
        return MyPage()
    }
}
