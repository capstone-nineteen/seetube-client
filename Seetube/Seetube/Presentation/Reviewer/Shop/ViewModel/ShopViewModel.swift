//
//  ShopViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/17.
//

import Foundation
import RxSwift
import RxCocoa

class ShopViewModel: ViewModelType {
    private let fetchTotalCoinAmountUseCase: FetchTotalCoinAmountUseCase
    
    init(fetchTotalCoinAmountUseCase: FetchTotalCoinAmountUseCase) {
        self.fetchTotalCoinAmountUseCase = fetchTotalCoinAmountUseCase
    }
    
    func transform(input: Input) -> Output {
        let total = input.viewWillAppear
            .flatMap { [weak self] _ -> Driver<Shop?> in
                guard let self = self else { return .just(nil) }
                return self.fetchTotalCoinAmountUseCase
                    .execute()
                    .asDriver(onErrorJustReturn: nil)
            }
            .compactMap { $0 }
            .map { $0.totalCoinAmount }
            
        let withdrawal = input.withdrawalAmountChanged
            .distinctUntilChanged()
            .map { $0 == "" ? "0" : $0 }
            .map { $0.replacingOccurrences(of: ",", with: "") }
            .map { Int($0) }
            .compactMap { $0 }
        
        let withdrawalAndTotal = Driver
            .combineLatest(
                total,
                withdrawal
            ) {
                return (total: $0, withdrawal: $1)
            }
        
        let recalculatedWithdrawal = withdrawalAndTotal
            .map { min($0.withdrawal, $0.total) }
        
        let remaining = Driver
            .combineLatest(
                total,
                recalculatedWithdrawal
            ) { $0 - $1 }
        
        let formattedTotal = total
            .map { $0.toFormattedString() }
        
        let formattedWithdrawal = recalculatedWithdrawal
            .map { $0.toFormattedString() }
            .map { $0 == "0" ? "" : $0 }
        
        let formattedRemaining = remaining
            .map { $0.toFormattedString() }
        
        let amountExceedError = withdrawalAndTotal
            .filter { $0.withdrawal > $0.total }
            .map { _ in () }
        
        return Output(total: formattedTotal,
                      withdrawal: formattedWithdrawal,
                      remaining: formattedRemaining,
                      amountExceedError: amountExceedError)
    }
}

extension ShopViewModel {
    struct Input {
        let viewWillAppear: Driver<Bool>
        let withdrawalAmountChanged: Driver<String>
    }
    
    struct Output {
        let total: Driver<String>
        let withdrawal: Driver<String>
        let remaining: Driver<String>
        let amountExceedError: Driver<Void>
    }
}