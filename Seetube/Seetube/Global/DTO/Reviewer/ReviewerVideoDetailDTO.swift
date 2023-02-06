//
//  ReviewerVideoDetailDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct ReviewerVideoDetailDTO: Decodable {
    let title: String
    let youtuberName: String
    let rewardAmount: Int
    let currentNumberOfReviewers: Int
    let targetNumberOfReviewers: Int
    let reviewPeriod: String
    let videoDescription: String
}
