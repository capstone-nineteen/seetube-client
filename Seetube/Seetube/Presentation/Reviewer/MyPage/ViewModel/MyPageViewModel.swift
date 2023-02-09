//
//  MyPageViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift
import RxCocoa

class MyPageViewModel {
    private let fetchMyPageUseCase: FetchMyPageUseCase
    
    init(fetchMyPageUseCase: FetchMyPageUseCase) {
        self.fetchMyPageUseCase = fetchMyPageUseCase
    }
    
    func transform(input: Input) -> Output {
        let myPage = input.viewWillAppear
            .flatMap { _ in
                self.fetchMyPageUseCase.execute()
                    .asDriver(onErrorJustReturn:
                        MyPage(name: "아무개",
                               coin: 12345,
                               coinHistories: [CoinHistory(date: Date(timeIntervalSinceNow: .zero),
                                                           content: "실패",
                                                           type: .earn,
                                                           amount: 99999),
                                               CoinHistory(date: Date(timeIntervalSinceNow: .zero),
                                                                           content: "실패",
                                                                           type: .use,
                                                                           amount: 12345)]
                        )
                    )
            }
        
        let name = myPage.map { $0.name + "님" }
        let coin = myPage.map { $0.coin.toFormattedString() }
        let coinHistories = myPage.map { myPage in
            myPage.coinHistories.map { CoinHistoryItemViewModel(with: $0) }
        }
        
        return Output(name: name,
                      coin: coin,
                      coinHistories: coinHistories)
    }
}

extension MyPageViewModel {
    struct Input {
        let viewWillAppear: Driver<Bool>
    }
    
    struct Output {
        let name: Driver<String>
        let coin: Driver<String>
        let coinHistories: Driver<[CoinHistoryItemViewModel]>
    }
}
