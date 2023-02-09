//
//  Endpoint.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Endpoint {
    var method: HttpMethod
    var url: String
    var parameters: [String: Any]? = nil
}
