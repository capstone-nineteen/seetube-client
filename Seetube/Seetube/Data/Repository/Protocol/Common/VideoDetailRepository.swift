//
//  VideoInfoRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation
import RxSwift

// TODO: 리턴 타입 Single로 교체
protocol VideoDetailRepository {
    func getVideoInfo(id: Int) -> Observable<VideoInfo?>
}
