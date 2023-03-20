//
//  RequestVerificationCodeUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation
import RxSwift

protocol RequestVerificationCodeUseCase {
    func execute(userType: UserType, email: String) -> Single<VerificationCodeRequestResult>
}
