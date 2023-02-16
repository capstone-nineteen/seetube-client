//
//  DefaultFetchTotalCoinAmountUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/17.
//

import Foundation
import RxSwift

class DefaultFetchTotalCoinAmountUseCase: FetchTotalCoinAmountUseCase {
    private let repository: ShopRepository
    
    init(repository: ShopRepository) {
        self.repository = repository
    }
    
    func execute() -> Observable<Shop?> {
        return self.repository.getShop()
    }
}
