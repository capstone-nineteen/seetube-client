//
//  EndpointFactory.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

class EndpointFactory {
    enum EndpointType {
        case getMyPage
        
        var method: HttpMethod {
            switch self {
            case .getMyPage:
                return .get
            }
        }
        
        var url: String {
            switch self {
            case .getMyPage:
                return APIUrls.myPage
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .getMyPage:
                return nil
            }
        }
    }
    
    static func makeEndpoint(for type: EndpointType) -> Endpoint {
        return Endpoint(method: type.method,
                        url: type.url,
                        parameters: type.parameters)
    }
}
