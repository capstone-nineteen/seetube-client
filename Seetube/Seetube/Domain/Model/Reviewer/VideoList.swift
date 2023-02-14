//
//  VideosByCategory.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

struct VideoList {
    let videos: [VideoInfo]
    
    init(videos: [VideoInfo] = []) {
        self.videos = videos
    }
}
