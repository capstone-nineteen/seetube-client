//
//  EmotionResultRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

protocol EmotionResultRepository {
    func getEmotionResult() -> Observable<EmotionResult>
}
