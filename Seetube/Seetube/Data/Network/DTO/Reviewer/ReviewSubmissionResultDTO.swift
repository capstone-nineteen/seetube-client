//
//  ReviewSubmissionResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/23.
//

import Foundation

struct ReviewSubmissionResultDTO: Decodable, DomainConvertible {
    let message: String
    let status: Int
    
    func toDomain() -> ReviewSubmissionResult {
        return ReviewSubmissionResult(message: self.message,
                                      status: self.status)
    }
}
