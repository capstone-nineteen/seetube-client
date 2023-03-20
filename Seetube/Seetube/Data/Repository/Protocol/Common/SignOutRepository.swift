//
//  SignOutRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/20.
//

import Foundation
import RxSwift

protocol SignOutRepository {
    func removeToken() -> Completable
}
