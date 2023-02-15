//
//  VideoDetailDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/15.
//

import Foundation

struct VideoDetailDTO: Decodable, DomainConvertible {
    let video: VideoInfoDTO
    
    func toDomain() -> VideoInfo {
        return video.toDomain()
    }
}
