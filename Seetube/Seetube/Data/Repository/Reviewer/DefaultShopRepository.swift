//
//  DefaultShopRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

class DefaultShopRepository: ShopRepository, NetworkRequestable {
    func getShop() -> Observable<Shop> {
        let endpoint = APIEndpointFactory.makeEndpoint(for: .getShop)
        return self.getResource(endpoint: endpoint,
                                decodingType: ShopDTO.self)
    }
}
