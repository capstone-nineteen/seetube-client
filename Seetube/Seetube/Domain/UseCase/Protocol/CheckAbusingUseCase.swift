//
//  CheckAbusingUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/04/15.
//

import Foundation
import RxSwift

protocol CheckAbusingUseCase {
    func execute(review: Review) -> Bool
}
