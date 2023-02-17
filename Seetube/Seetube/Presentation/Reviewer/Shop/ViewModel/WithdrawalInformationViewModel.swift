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
        
        let result = input.confirmButtonTouched
            .withLatestFrom(info) { $1 }
            .flatMap { [weak self] info -> Driver<Bool> in
                guard let self = self else { return .just(false) }
                return self.registerWithdrawalUseCase
                    .execute(info: info)
                    .asDriver(onErrorJustReturn: false)
            }
        
        let bankNameValidation = input.bankName
            .map { $0.count >= 2 }
        
        let accountHolderValidation = input.accountHolder
            .map { $0.count >= 2 }
        
        let accountNumberValidation = input.accountNumber
            .map { $0.count >= 10 }
        
        let validation = Driver
            .combineLatest(
                bankNameValidation,
                accountHolderValidation,
                accountNumberValidation
            ) { (bankName: $0, holder: $1, number: $2) }
        
        let validationError = input.registerButtonTouched
            .withLatestFrom(
                validation
            ) { _, validation -> String? in
                if !validation.bankName {
                    return "은행명를 2글자 이상 입력하세요."
                } else if !validation.holder {
                    return "예금주를 2글자 이상 입력하세요."
                } else if !validation.number {
                    return "계좌번호를 10글자 이상 입력하세요."
                } else {
                    return nil
                }
            }
        
        return Output(registerResult: result,
                      validationError: validationError)
    }
}

extension WithdrawalInformationViewModel {
    struct Input {
        let bankName: Driver<String>
        let accountHolder: Driver<String>
        let accountNumber: Driver<String>
        let registerButtonTouched: Driver<Void>
        let confirmButtonTouched: Driver<Void>
    }
    
    struct Output {
        let registerResult: Driver<Bool>
        let validationError: Driver<String?>
    }
}
