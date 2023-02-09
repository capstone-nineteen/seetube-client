//
//  CategoryDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct VideoListDTO: Decodable {
    let videos: [VideoInfoDTO]
}

extension VideoListDTO: DomainConvertible {
    func toDomain() -> VideoList {
        return VideoList()
    }
}
