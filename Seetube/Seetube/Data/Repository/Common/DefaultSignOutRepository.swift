//
//  DefaultSignOutRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/20.
//

import Foundation
import RxSwift

class DefaultSignOutRepository: SignOutRepository {
    func removeToken() -> Completable {
        return Completable.create { completable in
            KeychainHelper.standard.accessToken = nil
            UserDefaultHelper.shared.userType = nil
            completable(.completed)
            
            return Disposables.create()
        }
    }
}
