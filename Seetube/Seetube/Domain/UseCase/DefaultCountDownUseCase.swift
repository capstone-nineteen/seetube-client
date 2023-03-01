//
//  DefaultCountDownUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation
import RxSwift

class DefaultCountDownUseCase: CountDownUseCase {
    func execute(time: Int) -> Observable<Int> {
        return Observable<Int>
            .interval(RxTimeInterval.seconds(1),
                      scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
            .map { time - $0 }
            .take(time + 1)
            .startWith(time)
    }
}
