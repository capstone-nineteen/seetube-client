//
//  DefaultShopRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

class DefaultShopRepository: ShopRepository, NetworkRequestable {
    func getShop() -> Single<Shop> {
        let endpoint = APIEndpointFactory.makeEndpoint(for: .getShop)
        return self.getResource(endpoint: endpoint,
                                decodingType: ShopDTO.self)
    }
    
    func registerWithdrawal(info: WithdrawalInformation) -> Single<WithdrawalResult> {
        let infoDTO = info.toDTO()
        let endpoint = APIEndpointFactory.makeEndpoint(
            for: .registerWithdrawal(info: infoDTO)
        )
        return self.getResource(endpoint: endpoint,
                                decodingType: WithdrawalResultDTO.self)
    }
}
