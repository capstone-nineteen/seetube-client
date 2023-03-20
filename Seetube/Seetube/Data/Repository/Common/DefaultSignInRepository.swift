//
//  DefaultSignInRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/01.
//

import Foundation
import RxSwift

class DefaultSignInRepository: SignInRepository, NetworkRequestable {
    func signIn(userType: UserType, email: String, password: String) -> Single<SignInResult> {
        let endpoint = APIEndpointFactory.makeEndpoint(
            for: .signIn(userType: userType, email: email, password: password)
        )
        return self.getResource(endpoint: endpoint,
                                decodingType: SignInResultDTO.self)
    }
    
    func saveToken(token: String, userType: UserType) -> Observable<Bool> {
        return Observable.create { observable in
            KeychainHelper.standard.accessToken = token
            UserDefaultHelper.shared.userType = userType
            
            observable.onNext(true)
            observable.onCompleted()
            
            return Disposables.create()
        }
    }
}
