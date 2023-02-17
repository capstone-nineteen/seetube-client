//
//  WithdrawalInformationViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/17.
//

import Foundation
import RxCocoa
import RxSwift

class WithdrawalInformationViewModel: ViewModelType {
    private let registerWithdrawalUseCase: RegisterWithdrawalUseCase
    private let amount: Int
    
    init(
        registerWithdrawalUseCase: RegisterWithdrawalUseCase,
        amount: Int
    ) {
        self.registerWithdrawalUseCase = registerWithdrawalUseCase
        self.amount = amount
    }
    
    func transform(input: Input) -> Output {
        let info = Driver
            .combineLatest(
                input.bankName,
                input.accountHolder,
                input.accountNumber
            ) { [weak self] bankName, accountHolder, accountNumber -> WithdrawalInformation? in
                guard let self = self else { return nil }
                return WithdrawalInformation(amount: self.amount,
                                             bankName: bankName,
                                             accountHolder: accountHolder,
                                             accountNumber: accountNumber)
            }
            .compactMap { $0 }
        
        let result = input.registerButtonTouched
            .withLatestFrom(info) { $1 }
            .flatMap { [weak self] info -> Driver<Bool> in
                guard let self = self else { return .just(false) }
                return self.registerWithdrawalUseCase
                    .execute(info: info)
                    .asDriver(onErrorJustReturn: false)
            }
        
        return Output(registerResult: result)
    }
}

extension WithdrawalInformationViewModel {
    struct Input {
        let bankName: Driver<String>
        let accountHolder: Driver<String>
        let accountNumber: Driver<String>
        let registerButtonTouched: Driver<Void>
    }
    
    struct Output {
        let registerResult: Driver<Bool>
    }
}
