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
        case getVideosBySearchKeyword(keyword: String)
        case getVideosByCategory(category: String)
        case getShop
        case registerWithdrawal(info: WithDrawalInformationDTO)
        case getMyPage
        case getYoutuberHome
        case getConcentrationResult
        case getEmotionResult
        case getSceneStealerResult
        case getShortsResult
        case getHighlightResult
        
        var method: HttpMethod {
            switch self {
            case .getVideoInfo:
                return .get
            case .getReviewerHome:
                return .get
            case .getVideosBySearchKeyword:
                return .get
            case .getVideosByCategory:
                return .get
            case .getShop:
                return .get
            case .registerWithdrawal:
                return .post
            case .getMyPage:
                return .get
            case .getYoutuberHome:
                return .get
            case .getConcentrationResult:
                return .get
            case .getEmotionResult:
                return .get
            case .getSceneStealerResult:
                return .get
            case .getShortsResult:
                return .get
            case .getHighlightResult:
                return .get
            }
        }
        
        var url: String {
            switch self {
            case .getVideoInfo(let id):
                return APIUrls.videoInfo + "/\(id)"
            case .getReviewerHome:
                return APIUrls.reviewerHome
            case .getVideosBySearchKeyword:
                return APIUrls.search
            case .getVideosByCategory(let category):
                // TODO: url encoding 함수 분리, 강제언래핑 제거
                return APIUrls.category + "/\(category.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)"
            case .getShop:
                return APIUrls.shop
            case .registerWithdrawal:
                return APIUrls.withdraw
            case .getMyPage:
                return APIUrls.myPage
            case .getYoutuberHome:
                return ""
            case .getConcentrationResult:
                return ""
            case .getEmotionResult:
                return ""
            case .getSceneStealerResult:
                return ""
            case .getShortsResult:
                return ""
            case .getHighlightResult:
                return ""
            }
        }
        
        var parameters: [String:Any]? {
            switch self {
            case .getVideoInfo:
                return nil
            case .getReviewerHome:
                return nil
            case .getVideosBySearchKeyword(let keyword):
                return ["keyword": keyword]
            case .getVideosByCategory:
                return nil
            case .getShop:
                return nil
            case .registerWithdrawal(let info):
                return info.dictionary
            case .getMyPage:
                return nil
            case .getYoutuberHome:
                return nil
            case .getConcentrationResult:
                return nil
            case .getEmotionResult:
                return nil
            case .getSceneStealerResult:
                return nil
            case .getShortsResult:
                return nil
            case .getHighlightResult:
                return nil
            }
        }
    }
    
    static func makeEndpoint(for type: EndpointType) -> APIEndpoint {
        return APIEndpoint(method: type.method,
                           url: type.url,
                           parameters: type.parameters)
    }
}
