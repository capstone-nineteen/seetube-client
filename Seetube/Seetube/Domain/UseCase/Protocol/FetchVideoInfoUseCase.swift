//
//  FetchVideoInfoUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/15.
//

import Foundation
import RxSwift

protocol FetchVideoInfoUseCase {
    func execute(id: Int) -> Observable<VideoInfo>
}