//
//  SearchResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct SearchResultDTO: Decodable {
    let videos: [VideoInfoDTO]
}

extension SearchResultDTO: DomainConvertible {
    func toDomain() -> SearchResult {
        return SearchResult()
    }
}
