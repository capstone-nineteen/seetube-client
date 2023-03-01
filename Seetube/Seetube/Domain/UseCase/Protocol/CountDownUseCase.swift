//
//  CountDownUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation
import RxSwift

protocol CountDownUseCase {
    func execute(time: Int) -> Observable<Int>
}
