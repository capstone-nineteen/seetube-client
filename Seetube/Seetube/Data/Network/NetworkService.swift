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
    static func request(_ endpoint: APIEndpoint) -> Single<Data> {
        return RxAlamofire
            .requestData(HTTPMethod(rawValue: endpoint.method.rawValue),
                         endpoint.url,
                         parameters: endpoint.parameters,
                         encoding: endpoint.encoding,
                         headers: endpoint.headers)
            .asSingle()
            .map { (response, data) in
                switch response.statusCode {
                case 200..<300:
                    return data
                default:
                    throw NetworkServiceError.invalidResponse
                }
            }
    }
}
