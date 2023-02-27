//
//  SignUpInformation.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation

struct SignUpInformation: DTOConvertible {
    let nickname: String
    let email: String
    let password: String
    
    func toDTO() -> SignUpInformationDTO {
        SignUpInformationDTO(email: self.email,
                             name: self.nickname,
                             password: self.password)
    }
}
