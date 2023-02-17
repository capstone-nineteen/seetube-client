//
//  DefaultShopRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

class DefaultShopRepository: ShopRepository, NetworkRequestable {
    func getShop() -> Observable<Shop?> {
        let endpoint = APIEndpointFactory.makeEndpoint(for: .getShop)
        return self.getResource(endpoint: endpoint,
                                decodingType: ShopDTO.self)
    }
    
    func registerWithdrawal(info: WithdrawalInformation) -> Observable<WithdrawalResult?> {
        let infoDTO = info.toDTO()
        let endpoint = APIEndpointFactory.makeEndpoint(
            for: .registerWithdrawal(info: infoDTO)
        )
        return self.getResource(endpoint: endpoint,
                                decodingType: WithdrawalResultDTO.self)
    }
}
