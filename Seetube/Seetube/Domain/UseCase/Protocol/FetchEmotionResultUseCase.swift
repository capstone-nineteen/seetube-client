//
//  FetchEmotionResultUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/07.
//

import Foundation
import RxSwift

protocol FetchEmotionResultUseCase {
    func execute(videoId: Int) -> Observable<EmotionResult?>
}
