//
//  Endpoint.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import Alamofire

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct APIEndpoint {
    var method: HttpMethod
    var url: String
    var parameters: [String: Any]? = nil
    var encoding: ParameterEncoding
}
