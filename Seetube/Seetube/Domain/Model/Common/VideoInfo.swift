//
//  VideoInfo.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

struct VideoInfo {
    let videoId: Int
    let title: String
    let youtuberName: String
    let rewardAmount: Int
    let currentNumberOfReviewers: Int
    let targetNumberOfReviewers: Int
    let reviewStartDate: Date
    let reviewEndDate: Date
    let videoDescription: String
    let imagePath: String
    let videoPath: String
    var didReviewed: Bool
    
    static func dummyVideo() -> VideoInfo {
        VideoInfo(videoId: 123123,
                  title: "제목",
                  youtuberName: "dbxb",
                  rewardAmount: 300,
                  currentNumberOfReviewers: 20,
                  targetNumberOfReviewers: 80,
                  reviewStartDate: Date.distantPast,
                  reviewEndDate: Date.distantFuture,
                  videoDescription: "fjiejifwjiej",
                  imagePath: "",
                  videoPath: "",
                  didReviewed: false)
    }
}
