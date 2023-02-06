//
//  WithdrawInformationDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct WithDrawoInformationDTO: Codable {
    let amount: Int
    let bankName: String
    let accountHolder: String
    let accountNumber: String
}
