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
    
    static let videoInfo = reviewerBase + "/video"
    static let reviewerHome = reviewerBase + "/home"
    static let search = reviewerBase + "/videos/search"
    static let category = reviewerBase + "/videos/category"
    static let shop = reviewerBase + "/coin"
    static let withdraw = reviewerBase + "/withdraw"
    static let myPage = reviewerBase + "/mypage"
}
