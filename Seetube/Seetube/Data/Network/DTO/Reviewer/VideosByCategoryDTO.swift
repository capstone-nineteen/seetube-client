//
//  CategoryDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct VideosByCategoryDTO: Decodable {
    let videos: [VideoInfoDTO]
}

extension VideosByCategoryDTO: DomainConvertible {
    func toDomain() -> VideosByCategory {
        return VideosByCategory()
    }
}
