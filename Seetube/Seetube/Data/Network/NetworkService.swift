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

enum NetworkServiceError: Error {
    case invalidResponse
}

class NetworkService {
    static func request(_ endpoint: APIEndpoint) -> Observable<Data> {
        return RxAlamofire
            .requestData(HTTPMethod(rawValue: endpoint.method.rawValue),
                         endpoint.url,
                         parameters: endpoint.parameters,
                         encoding: endpoint.encoding,
                         headers: endpoint.headers)
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
