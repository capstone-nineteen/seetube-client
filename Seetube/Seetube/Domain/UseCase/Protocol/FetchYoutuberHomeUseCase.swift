//
//  FetchYoutuberHomeUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/03.
//

import Foundation
import RxSwift

protocol FetchYoutuberHomeUseCase {
    func execute() -> Single<YoutuberHome>
}
