//
//  DTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

protocol DomainConvertible {
    associatedtype DomainModel
    func toDomain() -> DomainModel
}
