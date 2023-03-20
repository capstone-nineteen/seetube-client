//
//  DefaultRegisterWithdrawalUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/17.
//

import Foundation
import RxSwift

class DefaultRegisterWithdrawalUseCase: RegisterWithdrawalUseCase {
    private let repository: ShopRepository
    
    init(repository: ShopRepository) {
        self.repository = repository
    }
    
    func execute(info: WithdrawalInformation) -> Completable {
        return self.repository.registerWithdrawal(info: info)
            .map {
                if $0.status != 201 {
                    throw NetworkServiceError.requestFailed
                } else {
                    return $0
                }
            }
            .asCompletable()
    }
}
