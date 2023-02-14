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
    
    static func dummy() -> [ReviewerHomeSection] {
        let section = ReviewerHomeSection(category: .beauty,
                                   videos: [VideoInfo.dummyVideo(),
                                            VideoInfo.dummyVideo()
                                           ])
        return [section, section, section, section]
    }
}

struct ReviewerHome {
    let name: String
    let coin: Int
    let sections: [ReviewerHomeSection]
    
    init(name: String = "",
         coin: Int = 0,
         sections: [ReviewerHomeSection] = ReviewerHomeSection.dummy()) {
        self.name = name
        self.coin = coin
        self.sections = sections
    }
}
