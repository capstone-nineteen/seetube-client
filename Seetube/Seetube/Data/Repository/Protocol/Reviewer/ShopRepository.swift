//
//  ShopRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

protocol ShopRepository {
    func getShop() -> Single<Shop>
    func registerWithdrawal(info: WithdrawalInformation) -> Single<WithdrawalResult>
}
