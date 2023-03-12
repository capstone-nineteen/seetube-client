//
//  FetchHighlightResultUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/12.
//

import Foundation
import RxSwift

protocol FetchHighlightResultUseCase {
    func execute(videoId: Int) -> Observable<HighlightResult?>
}
