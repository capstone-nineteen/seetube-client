//
//  ReviewerVideoDetailDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct VideoInfoDTO: Decodable, DomainConvertible {
    let id: String
    let videoTitle: String
    let creator: String
    let videoCoin: Int
    let reviewCurrent: Int
    let reviewGoal: Int
    let createdAt: Date
    let reviewDate: Date
    let videoDetail: String
    let imagePath: String
    let videoPath: String
    let isReviewerReviewed: Bool?
    
    func toDomain() -> VideoInfo {
        return VideoInfo(title: self.videoTitle,
                         youtuberName: self.creator,
                         rewardAmount: self.videoCoin,
                         currentNumberOfReviewers: self.reviewCurrent,
                         targetNumberOfReviewers: self.reviewGoal,
                         reviewStartDate: self.createdAt,
                         reviewEndDate: self.reviewDate,
                         videoDescription: self.videoDetail,
                         imagePath: self.imagePath,
                         videoPath: self.videoPath,
                         videoId: self.id)
    }
}
