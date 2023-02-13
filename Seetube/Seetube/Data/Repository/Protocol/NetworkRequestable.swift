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
    func getResource<T: DTO>(endpoint: APIEndpoint, decodingType: T.Type) -> Observable<T.DomainModel>
}

extension NetworkRequestable {
    func getResource<T: DTO>(endpoint: APIEndpoint, decodingType: T.Type) -> Observable<T.DomainModel> {
        NetworkService
            .request(endpoint)
            .retry(3)
            .map {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                return try decoder.decode(T.self, from: $0)
            }
            .map { $0.toDomain() }
    }
}
