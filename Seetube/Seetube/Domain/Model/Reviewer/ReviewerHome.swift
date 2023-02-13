//
//  ReviewerHome.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

struct ReviewerHomeSection {
    let category: Category
    let videos: [VideoInfo]
    
    subscript (index: Int) -> VideoInfo {
        return self.videos[index]
    }
}

struct ReviewerHome {
    let name: String
    let coin: Int
    let sections: [ReviewerHomeSection]
    
    init(name: String = "",
         coin: Int = 0,
         sections: [ReviewerHomeSection] = []) {
        self.name = name
        self.coin = coin
        self.sections = sections
    }
}
