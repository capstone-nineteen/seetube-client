//
//  FetchVideoInfoUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/15.
//

import Foundation
import RxSwift

protocol FetchVideoDetailUseCase {
    func execute(id: Int) -> Observable<VideoInfo?>
}
