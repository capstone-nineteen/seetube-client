//
//  SignUpDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation

struct SignUpInformationDTO: Encodable {
    let email: String
    let name: String
    let password: String
}
