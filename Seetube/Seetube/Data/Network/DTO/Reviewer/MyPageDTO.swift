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
    
    func toDomain(coinHistoryType: CoinHistoryType) -> CoinHistory {
        return CoinHistory(date: self.date,
                           content: self.content,
                           type: coinHistoryType,
                           amount: self.amount)
    }
}

struct MyPageDTO: Decodable {
    let name: String
    let coin: Int
    let withdrawHistories: [CoinHistoryDTO]
    let reviewHistories: [CoinHistoryDTO]
}

extension MyPageDTO: DomainConvertible {
    private func combineAllHistories() -> [CoinHistory] {
        let usageHistories = self.withdrawHistories.map { $0.toDomain(coinHistoryType: .use) }
        let earningHistories = self.reviewHistories.map { $0.toDomain(coinHistoryType: .earn) }
        return usageHistories + earningHistories
    }
    
    func toDomain() -> MyPage {
        return MyPage(name: self.name,
                      coin: self.coin,
                      coinHistories: self.combineAllHistories())
    }
}
