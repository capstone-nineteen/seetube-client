//
//  HighlightResultRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

protocol HighlightResultRepository {
    func getHighlightResult(videoId: Int) -> Single<HighlightResult>
}
