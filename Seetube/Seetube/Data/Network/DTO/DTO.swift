//
//  DTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

protocol DTO: Decodable {
    associatedtype DomainModel
    func toDomain() -> DomainModel
}
