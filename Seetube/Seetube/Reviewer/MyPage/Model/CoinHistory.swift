//
//  CoinHistory.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/04.
//

import Foundation

struct CoinHistory {
    enum UsageType {
        case use
        case earn
    }
    
    let usageType: UsageType
    let date: String
    let content: String
    let amount: Int
}
