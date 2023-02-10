//
//  ReviewerVideoDetailDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct VideoInfoDTO: Decodable, DomainConvertible {
    let title: String
    let youtuberName: String
    let rewardAmount: Int
    let currentNumberOfReviewers: Int
    let targetNumberOfReviewers: Int
    let reviewStartDate: Date
    let reviewEndDate: Date
    let videoDescription: String
    
    func toDomain() -> VideoInfo {
        return VideoInfo(title: self.title,
                         youtuberName: self.youtuberName,
                         rewardAmount: self.rewardAmount,
                         currentNumberOfReviewers: self.currentNumberOfReviewers,
                         targetNumberOfReviewers: self.targetNumberOfReviewers,
                         reviewStartDate: self.reviewStartDate,
                         reviewEndDate: self.reviewEndDate,
                         videoDescription: self.videoDescription)
    }
}
