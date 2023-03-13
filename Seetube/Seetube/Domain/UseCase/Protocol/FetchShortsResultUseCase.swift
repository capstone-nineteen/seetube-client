//
//  FetchShortsResultUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/13.
//

import Foundation
import RxSwift

protocol FetchShortsResultUseCase {
    func execute(videoId: Int) -> Observable<ShortsResult?>
}
