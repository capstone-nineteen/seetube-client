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
    
    init(
        category: Category = .all,
        videos: [VideoInfo] = [VideoInfo(), VideoInfo()]
    ) {
        self.category = category
        self.videos = videos
    }
}

struct ReviewerHome {
    let name: String
    let coin: Int
    let sections: [ReviewerHomeSection]
    
    init(name: String = "",
         coin: Int = 0,
         sections: [ReviewerHomeSection] = [ReviewerHomeSection(),
                                            ReviewerHomeSection(),
                                            ReviewerHomeSection(),
                                            ReviewerHomeSection()]) {
        self.name = name
        self.coin = coin
        self.sections = sections
    }
}
