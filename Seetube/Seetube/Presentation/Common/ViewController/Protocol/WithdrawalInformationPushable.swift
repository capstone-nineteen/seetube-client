//
//  WithdrawalInformationPushable.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/17.
//

import Foundation

protocol WithdrawalInformationPushable: ViewControllerPushable {
    func pushWithdrawalInfromation(withdrawlAmount: Int)
}

extension WithdrawalInformationPushable {
    func pushWithdrawalInfromation(withdrawlAmount: Int) {
        self.push(
            viewControllerType: WithdrawalInformationViewController.self
        ) { viewController in
            // TODO: 의존성 주입
        }
    }
}
