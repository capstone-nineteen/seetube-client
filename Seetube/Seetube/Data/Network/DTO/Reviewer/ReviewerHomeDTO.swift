//
//  ReviewerHomeDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct ReviewerHomeSectionDTO: Decodable {
    let title: String
    let videos: [VideoInfoDTO]
}

struct ReviewerHomeDTO: Decodable {
    let userName: String
    let coin: Int
    let sections: [ReviewerHomeSectionDTO]
}

extension ReviewerHomeDTO: DomainConvertible {
    func toDomain() -> ReviewerHome {
        return ReviewerHome()
    }
}
