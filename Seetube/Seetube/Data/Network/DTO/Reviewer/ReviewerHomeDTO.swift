//
//  ReviewerHomeDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct ReviewerHomeSectionDTO: Decodable, DomainConvertible {
    let title: String
    let videos: [VideoInfoDTO]
    
    func toDomain() -> ReviewerHomeSection {
        return ReviewerHomeSection(title: self.title,
                                   videos: self.videos.map{ $0.toDomain() })
    }
}

struct ReviewerHomeDTO: Decodable, DomainConvertible {
    let userName: String
    let coin: Int
    let sections: [ReviewerHomeSectionDTO]
    
    func toDomain() -> ReviewerHome {
        return ReviewerHome(name: self.userName,
                            coin: self.coin,
                            sections: self.sections.map { $0.toDomain() })
    }
}
