//
//  EndpointFactory.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

class APIEndpointFactory {
    enum EndpointType {
        case getMyPage
        case getVideoInfo
        
        var method: HttpMethod {
            switch self {
            case .getMyPage : return .get
            case .getVideoInfo: return .get
            }
        }
        
        var url: String {
            switch self {
            case .getMyPage: return ""
            case .getVideoInfo: return ""
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .getMyPage: return nil
            case .getVideoInfo: return nil
            }
        }
    }
    
    static func makeEndpoint(for type: EndpointType) -> APIEndpoint {
        return APIEndpoint(method: type.method,
                        url: type.url,
                        parameters: type.parameters)
    }
}
