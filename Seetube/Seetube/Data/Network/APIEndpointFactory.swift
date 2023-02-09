//
//  EndpointFactory.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

class APIEndpointFactory {
    enum EndpointType {
        case getVideoInfo
        case getReviewerHome
        case getVideosByCategory
        case getShop
        case getMyPage
        case getYoutuberHome
        case getConcentrationResult
        case getEmotionResult
        case getSceneStealerResult
        case getShortsResult
        case getHighlightResult
        
        var method: HttpMethod {
            switch self {
            case .getVideoInfo: return .get
            case .getReviewerHome: return .get
            case .getVideosByCategory: return .get
            case .getShop: return .get
            case .getMyPage: return .get
            case .getYoutuberHome: return .get
            case .getConcentrationResult: return .get
            case .getEmotionResult: return .get
            case .getSceneStealerResult: return .get
            case .getShortsResult: return .get
            case .getHighlightResult: return .get
            }
        }
        
        var url: String {
            switch self {
            case .getVideoInfo: return ""
            case .getReviewerHome: return ""
            case .getVideosByCategory: return ""
            case .getShop: return ""
            case .getMyPage: return ""
            case .getYoutuberHome: return ""
            case .getConcentrationResult: return ""
            case .getEmotionResult: return ""
            case .getSceneStealerResult: return ""
            case .getShortsResult: return ""
            case .getHighlightResult: return ""
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .getVideoInfo: return nil
            case .getReviewerHome: return nil
            case .getVideosByCategory: return nil
            case .getShop: return nil
            case .getMyPage: return nil
            case .getYoutuberHome: return nil
            case .getConcentrationResult: return nil
            case .getEmotionResult: return nil
            case .getSceneStealerResult: return nil
            case .getShortsResult: return nil
            case .getHighlightResult: return nil
            }
        }
    }
    
    static func makeEndpoint(for type: EndpointType) -> APIEndpoint {
        return APIEndpoint(method: type.method,
                        url: type.url,
                        parameters: type.parameters)
    }
}
