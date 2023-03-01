//
//  Driver+Extension.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/01.
//

import Foundation
import RxCocoa
import RxSwift

extension Driver {
    func mapToVoid() -> Driver<Void> {
        return map { _ in () as Void? }
            .asDriver(onErrorJustReturn: nil)
            .compactMap { $0 }
    }
}
