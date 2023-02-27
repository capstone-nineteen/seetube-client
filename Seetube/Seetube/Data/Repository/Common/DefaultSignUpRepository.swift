//
//  DefaultSignUpRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation
import RxSwift

class DefaultSignUpRepository: SignUpRepository, NetworkRequestable {
    func signUp(userType: UserType, info: SignUpInformation) -> Observable<SignUpResult?> {
        let infoDTO = info.toDTO()
        let endpoint = APIEndpointFactory.makeEndpoint(
            for: .signUp(userType: userType, info: infoDTO)
        )
        return self.getResource(endpoint: endpoint,
                                decodingType: SignUpResultDTO.self)
    }
}
