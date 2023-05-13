//
//  APIUrls.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

enum APIUrls {
    private static let base = "http://3.39.99.10:8001"
    private static let reviewerBase = base + "/reviewer"
    private static let youtuberBase = base + "/youtuber"
    
    static let reviewerVerificationCode = reviewerBase + "/email"
    static let reviewerSignUp = reviewerBase + "/signup"
    static let reviewerSignIn = reviewerBase + "/login"
    static let videoInfo = reviewerBase + "/video"
    static let reviewerHome = reviewerBase + "/home"
    static let search = reviewerBase + "/videos/search"
    static let category = reviewerBase + "/videos/category"
    static let shop = reviewerBase + "/coin"
    static let withdraw = reviewerBase + "/withdraw"
    static let submitReview = reviewerBase + "/watchingInfo"
    static let myPage = reviewerBase + "/mypage"

    static let youtuberVerificationCode = youtuberBase + "/email"
    static let youtuberSignUp = youtuberBase + "/signup"
    static let youtuberSignIn = youtuberBase + "/login"
    static let youtuberHome = youtuberBase + "/home"
    static let concentrationResult = youtuberBase + "/focus"
    static let emotionResult = youtuberBase + "/emotion"
    static let sceneStealerResult = youtuberBase + "/sceneStealer"
    static let highlightResult = youtuberBase + "/highlight"
    static let shortsResult = youtuberBase + "/shorts"
}
