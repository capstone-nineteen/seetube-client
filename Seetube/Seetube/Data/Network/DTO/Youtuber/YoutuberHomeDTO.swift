//
//  YoutuberHomeDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct YoutuberHomeDTO: Decodable {
    let userName: String
    let finishedReviews: [VideoInfoDTO]
    let reviewsInProgress: [VideoInfoDTO]
}

extension YoutuberHomeDTO: DomainConvertible {
    func toDomain() -> YoutuberHome {
        return YoutuberHome(userName: self.userName,
                            finishedReviews: self.finishedReviews.map { $0.toDomain() },
                            reviewsInProgress: self.reviewsInProgress.map { $0.toDomain() })
    }
}
