//
//  MyPage.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

enum CoinHistoryType {
    case earn
    case use
}

struct CoinHistory {
    let date: Date
    let content: String
    let type: CoinHistoryType
    let amount: Int
}

struct MyPage {
    let name: String
    let coin: Int
    let coinHistories: [CoinHistory]
    
    init(name: String = "",
         coin: Int = 0,
         coinHistories: [CoinHistory] = []
    ) {
        self.name = name
        self.coin = coin
        self.coinHistories = coinHistories
    }
}
