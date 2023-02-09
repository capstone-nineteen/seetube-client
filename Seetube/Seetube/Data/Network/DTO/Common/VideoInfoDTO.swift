//
//  ReviewerVideoDetailDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct VideoInfoDTO: Decodable {
    let title: String
    let youtuberName: String
    let rewardAmount: Int
    let currentNumberOfReviewers: Int
    let targetNumberOfReviewers: Int
    let reviewStartDate: Date
    let reviewEndDate: Date
    let videoDescription: String
}

extension VideoInfoDTO: DomainConvertible {
    func toDomain() -> VideoInfo {
        return VideoInfo()
    }
}
