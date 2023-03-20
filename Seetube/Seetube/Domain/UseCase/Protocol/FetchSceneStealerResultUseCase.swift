//
//  FetchSceneStealerResult.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/11.
//

import Foundation
import RxSwift

protocol FetchSceneStealerResultUseCase {
    func execute(videoId: Int) -> Single<SceneStealerResult>
}
