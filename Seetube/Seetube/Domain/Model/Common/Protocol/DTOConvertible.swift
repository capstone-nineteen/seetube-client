//
//  DTOConvertible.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/17.
//

import Foundation

protocol DTOConvertible {
    associatedtype DTO
    func toDTO() -> DTO
}
