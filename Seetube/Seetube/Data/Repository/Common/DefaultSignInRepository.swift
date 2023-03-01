//
//  DefaultSignInRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/01.
//

import Foundation
import RxSwift

class DefaultSignInRepository: SignInRepository, NetworkRequestable {
    func signIn(userType: UserType, email: String, password: String) -> Observable<SignInResult?> {
        let endpoint = APIEndpointFactory.makeEndpoint(
            for: .signIn(userType: userType, email: email, password: password)
        )
        return self.getResource(endpoint: endpoint,
                                decodingType: SignInResultDTO.self)
    }
}
