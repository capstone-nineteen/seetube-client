//
//  ObservableType+Extension.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/21.
//

import RxSwift
import RxCocoa

extension ObservableType {
    func mapToVoid() -> Observable<Void> {
        return self.map { _ in }
    }
    
    func asDriverIgnoringError() -> Driver<Element> {
        self.map { $0 as Element? }
            .asDriver(onErrorJustReturn: nil)
            .compactMap { $0 }
    }
}
