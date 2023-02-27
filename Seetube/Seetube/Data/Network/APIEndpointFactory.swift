//
//  EndpointFactory.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import Alamofire

class APIEndpointFactory {
    enum EndpointType {
        case requestVerificationCode(userType: UserType, email: String)
        case signUp(userType: UserType, info: SignUpInformationDTO)
        case getVideoInfo(id: Int)
        case getReviewerHome
        case getVideosBySearchKeyword(keyword: String)
        case getVideosByCategory(category: String)
        case getShop
        case registerWithdrawal(info: WithDrawalInformationDTO)
        case submitReview(videoId: Int, reviews: ReviewsDTO)
        case getMyPage
        case getYoutuberHome
        case getConcentrationResult
        case getEmotionResult
        case getSceneStealerResult
        case getShortsResult
        case getHighlightResult
        
        var method: HttpMethod {
            switch self {
            case .requestVerificationCode:
                return .post
            case .signUp:
                return .post
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
            case .submitReview:
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
            case .requestVerificationCode(let userType, _):
                switch userType {
                case .youtuber:
                    return APIUrls.youtuberVerificationCode
                case .reviewer:
                    return APIUrls.reviewerVerificationCode
                }
            case .signUp(let userType, _):
                switch userType {
                case .youtuber:
                    return APIUrls.youtuberSignUp
                case .reviewer:
                    return APIUrls.reviewerSignUp
                }
            case .getVideoInfo(let id):
                return APIUrls.videoInfo + "/\(id)"
            case .getReviewerHome:
                return APIUrls.reviewerHome
            case .getVideosBySearchKeyword:
                return APIUrls.search
            case .getVideosByCategory(let category):
                return APIUrls.category + "/\(category.urlPathAllowedEncoded)"
            case .getShop:
                return APIUrls.shop
            case .registerWithdrawal:
                return APIUrls.withdraw
            case .submitReview(let videoId, _):
                return APIUrls.submitReview + "?videoId=\(videoId)"
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
            case .requestVerificationCode(_, let email):
                return ["email": email]
            case .signUp(_, let info):
                return info.dictionary
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
            case .submitReview(_, let reviews):
                return reviews.dictionary
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
        
        var encoding: ParameterEncoding {
            switch self.method {
            case .get:
                return URLEncoding.default
            case .post:
                return JSONEncoding.default
            }
        }
    }
    
    static func makeEndpoint(for type: EndpointType) -> APIEndpoint {
        return APIEndpoint(method: type.method,
                           url: type.url,
                           parameters: type.parameters,
                           encoding: type.encoding)
    }
}
