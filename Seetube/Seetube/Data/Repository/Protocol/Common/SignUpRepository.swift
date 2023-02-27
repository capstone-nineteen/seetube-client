//
//  SignUpRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation
import RxSwift

protocol SignUpRepository {
    func requestVerificationCode(userType: UserType, email: String) -> Observable<VerificationCodeRequestResult?>
    func signUp(userType: UserType, info: SignUpInformation) -> Observable<SignUpResult?>
}
