//
//  WithdrawInformationDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct WithDrawalInformationDTO: Encodable {
    let amount: Int
    let bankName: String
    let accountHolder: String
    let accountNumber: String
}
