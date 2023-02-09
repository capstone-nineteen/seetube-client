//
//  CoinHistoryItemViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/10.
//

import Foundation

class CoinHistoryItemViewModel {
    let date: String
    let content: String
    let type: CoinHistoryType
    let amount: String
    
    init(with coinHistory: CoinHistory) {
        self.date = coinHistory.date.toyyMMddStyleWithDot()
        self.content = coinHistory.content
        self.type = coinHistory.type
        
        let formattedAbsoluteAmount = coinHistory.amount.toFormattedString()
        switch coinHistory.type {
        case .earn:
            self.amount = "+" + formattedAbsoluteAmount
        case .use:
            self.amount = "-" + formattedAbsoluteAmount
        }
    }
}
