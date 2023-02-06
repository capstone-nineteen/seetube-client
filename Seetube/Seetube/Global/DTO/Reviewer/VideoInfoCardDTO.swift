//
//  VideoInfoCardDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct VideoInfoCardDTO: Decodable {
    let title: String
    let youtuberName: String
    let remainingPeriod: String
    let currentNumberOfReviewers: Int
    let targetNumberOfReviewers: Int
    let rewardAmount: Int
}
