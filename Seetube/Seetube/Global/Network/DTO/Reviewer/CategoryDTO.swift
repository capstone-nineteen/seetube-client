//
//  CategoryDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct CategoryDTO: Decodable {
    let videos: [VideoInfoDTO]
}
