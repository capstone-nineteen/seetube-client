//
//  YoutuberHomeDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct ReviewInProgressInfoCardDTO: Decodable {
    let title: String
    let youtuberName: String
    let remainingPeriod: String
    let currentNumberOfReviewers: Int
    let targetNumberOfReviewers: Int
}

struct FinishedReviewInfoCardDTO: Decodable {
    let title: String
    let youtuberName: String
    let reviewPeriod: String
    let numberOfReviewers: Int
}

struct YoutuberHomeDTO: Decodable {
    let userName: String
    let finishedReviews: [FinishedReviewInfoCardDTO]
    let reviewsInProgress: [ReviewInProgressInfoCardDTO]
}
