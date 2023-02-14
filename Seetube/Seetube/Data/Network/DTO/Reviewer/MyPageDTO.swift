//
//  MyPageDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct WithdrawHistoryDTO: Decodable {
    let withdrawCoin: Int
    let withdrawDate: Date
    
    func toDomain() -> CoinHistory {
        return CoinHistory(date: self.withdrawDate,
                           content: "환급",
                           type: .use,
                           amount: self.withdrawCoin)
    }
}

struct ReviewHistoryDTO: Decodable {
    struct Video: Decodable {
        let videoTitle: String
        let videoCoin: Int
    }
    
    let reviewDate: Date
    let video: Video
    
    func toDomain() -> CoinHistory {
        return CoinHistory(date: self.reviewDate,
                           content: self.video.videoTitle,
                           type: .earn,
                           amount: self.video.videoCoin)
    }
}

struct MyPageDTO: Decodable {
    let name: String
    let coin: Int
    let withdrawHistories: [WithdrawHistoryDTO]
    let reviewHistories: [ReviewHistoryDTO]
}

extension MyPageDTO: DomainConvertible {
    private func combineAllHistories() -> [CoinHistory] {
        let usageHistories = self.withdrawHistories.map { $0.toDomain() }
        let earningHistories = self.reviewHistories.map { $0.toDomain() }
        return usageHistories + earningHistories
    }
    
    func toDomain() -> MyPage {
        return MyPage(name: self.name,
                      coin: self.coin,
                      coinHistories: self.combineAllHistories())
    }
}
