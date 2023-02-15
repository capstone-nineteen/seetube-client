//
//  CategoryDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct VideoListDTO: Decodable, DomainConvertible {
    let videos: [VideoInfoDTO]
    
    func toDomain() -> VideoList {
        return VideoList(videos: self.videos.map { $0.toDomain() })
    }
}
