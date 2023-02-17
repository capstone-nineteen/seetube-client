//
//  WithdrawInformation.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

struct WithdrawalInformation: DTOConvertible {
    let amount: Int
    let bankName: String
    let accountHolder: String
    let accountNumber: String
    
    func toDTO() -> WithDrawalInformationDTO {
        return WithDrawalInformationDTO(amount: self.amount,
                                      bankName: self.bankName,
                                      accountHolder: self.accountHolder,
                                      accountNumber: self.accountNumber)
    }
}
