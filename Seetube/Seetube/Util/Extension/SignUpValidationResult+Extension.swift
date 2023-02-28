//
//  SignUpValidationResult+Extension.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import UIKit
import RxCocoa
import RxSwift

extension Driver where Element == SignUpValidationResult {
    func mapToColor() -> Driver<UIColor> {
        return self
            .map { $0.isValid ? .black : .red }
            .asDriver(onErrorJustReturn: UIColor.clear)
    }
}
