//
//  VideoInfoRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

protocol VideoInfoRepository {
    func getVideoInfo() -> Observable<VideoInfo>
}
