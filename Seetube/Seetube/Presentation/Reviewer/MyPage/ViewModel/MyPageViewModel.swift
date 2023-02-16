//
//  MyPageViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift
import RxCocoa

class MyPageViewModel: ViewModelType {
    private let fetchMyPageUseCase: FetchMyPageUseCase
    
    init(fetchMyPageUseCase: FetchMyPageUseCase) {
        self.fetchMyPageUseCase = fetchMyPageUseCase
    }
    
    func transform(input: Input) -> Output {
        let myPage = input.viewWillAppear
            .flatMap { _ in
                self.fetchMyPageUseCase.execute()
                    .asDriver(onErrorJustReturn: nil)
            }
            .compactMap { $0 }
        
        let name = myPage
            .map { "\($0.name)님" }
        
        let coin = myPage
            .map { $0.coin.toFormattedString() }
        
        let coinHistories = myPage
            .map {
                $0.coinHistories.map { coinHistory in
                    return CoinHistoryItemViewModel(with: coinHistory)
                }
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
