//
//  RegisterWithdrawalUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/17.
//

import Foundation
import RxSwift

protocol RegisterWithdrawalUseCase {
    func execute(info: WithdrawalInformation) -> Observable<Bool>
}
