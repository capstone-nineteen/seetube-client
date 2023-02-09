//
//  DefaultMyPageRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

class DefaultMyPageRepository: MyPageRepository {
    func getMyPage() -> Observable<MyPage> {
        let endpoint: Endpoint<MyPageDTO> = EndpointFactory.makeEndpoint(for: .getMyPage)
        return NetworkService
            .request(endpoint)
            .map { $0.toDomain() }
    }
}
