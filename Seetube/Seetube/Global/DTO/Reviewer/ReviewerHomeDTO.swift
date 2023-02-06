//
//  ReviewerHomeDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct ReviewerHomeSectionDTO {
    let title: String
    let videos: [VideoInfoCardDTO]
}

struct ReviewerHomeDTO {
    let userName: String
    let coint: Int
    let sections: [ReviewerHomeSectionDTO]
}
