//
//  ReviewerHome.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

struct ReviewerHomeSection {
    let title: String
    let videos: [VideoInfo]
}

struct ReviewerHome {
    let name: String
    let coin: Int
    let sections: [ReviewerHomeSection]
}
