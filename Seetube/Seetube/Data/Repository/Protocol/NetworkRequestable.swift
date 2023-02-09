//
//  NetworkRequestable.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

typealias DTO = DomainConvertible & Decodable

protocol NetworkRequestable {
    func getResource<T: DTO>(endpoint: Endpoint, decodingType: T.Type) -> Observable<T.DomainModel>
}

extension NetworkRequestable {
    func getResource<T: DTO>(endpoint: Endpoint, decodingType: T.Type) -> Observable<T.DomainModel> {
        NetworkService
            .request(endpoint)
            .retry(3)
            .map { try JSONDecoder().decode(T.self, from: $0) }
            .map { $0.toDomain() }
    }
}
