//
//  SignInRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/01.
//

import Foundation
import RxSwift

protocol SignInRepository {
    func signIn(userType: UserType, email: String, password: String) -> Observable<SignInResult?>
}
