//
//  DefaultSignUpRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation
import RxSwift

class DefaultSignUpRepository: SignUpRepository, NetworkRequestable {
    func requestVerificationCode(userType: UserType, email: String) -> Observable<VerificationCodeRequestResult?> {
        let endpoint = APIEndpointFactory.makeEndpoint(
            for: .requestVerificationCode(userType: userType, email: email)
        )
        return self.getResource(endpoint: endpoint,
                                decodingType: VerificationCodeRequestResultDTO.self)
    }
    
    func signUp(userType: UserType, info: SignUpInformation) -> Observable<SignUpResult?> {
        let infoDTO = info.toDTO()
        let endpoint = APIEndpointFactory.makeEndpoint(
            for: .signUp(userType: userType, info: infoDTO)
        )
        return self.getResource(endpoint: endpoint,
                                decodingType: SignUpResultDTO.self)
    }
}
