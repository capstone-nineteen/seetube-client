//
//  FetchConcentrationResultUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/06.
//

import Foundation
import RxSwift

protocol FetchConcentrationResultUseCase {
    func execute(videoId: Int) -> Single<ConcentrationResult>
}
