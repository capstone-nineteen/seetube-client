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

struct Endpoint<T: Decodable> {
    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    var method: HttpMethod
    var url: String
    var parameters: [String: Any]? = nil
}

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
