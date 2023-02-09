//
//  DefaultMyPageRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

class DefaultMyPageRepository: MyPageRepository, NetworkRequestable {
    func getMyPage() -> Observable<MyPage> {
        let endpoint = APIEndpointFactory.makeEndpoint(for: .getMyPage)
        return self.getResource(endpoint: endpoint,
                                decodingType: MyPageDTO.self)
    }
}
