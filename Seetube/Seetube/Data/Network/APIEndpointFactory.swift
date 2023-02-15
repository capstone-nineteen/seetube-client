//
//  EndpointFactory.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

class APIEndpointFactory {
    enum EndpointType {
        case getVideoInfo(id: Int)
        case getReviewerHome
        case getVideosBySearchKeyword
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
            case .getVideosBySearchKeyword: return .get
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
            case .getVideoInfo(let id): return APIUrls.videoInfo + "/\(id)"
            case .getReviewerHome: return APIUrls.reviewerHome
            case .getVideosBySearchKeyword: return APIUrls.getVideosBySearchKeyword
            case .getVideosByCategory: return ""
            case .getShop: return ""
            case .getMyPage: return APIUrls.myPage
            case .getYoutuberHome: return ""
            case .getConcentrationResult: return ""
            case .getEmotionResult: return ""
            case .getSceneStealerResult: return ""
            case .getShortsResult: return ""
            case .getHighlightResult: return ""
            }
        }
    }
    
    static func makeEndpoint(
        for type: EndpointType,
        parameters: [String: Any]? = nil
    ) -> APIEndpoint {
        return APIEndpoint(method: type.method,
                           url: type.url,
                           parameters: parameters)
    }
}
