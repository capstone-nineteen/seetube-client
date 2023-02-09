//
//  APIService.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/08.
//

import Foundation
import RxAlamofire
import RxSwift
import Alamofire

class NetworkService {
    static func request<T>(_ endpoint: Endpoint<T>) -> Observable<T> {
        return RxAlamofire
            .requestData(HTTPMethod(rawValue: endpoint.method.rawValue),
                         endpoint.url,
                         parameters: endpoint.parameters)
            .map({ (response, data) -> T in
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            })
    }
}
