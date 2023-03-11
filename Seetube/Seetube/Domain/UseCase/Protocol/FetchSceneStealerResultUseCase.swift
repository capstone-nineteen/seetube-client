//
//  FetchSceneStealerResult.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/11.
//

import Foundation
import RxSwift

protocol FetchSceneStealerResultUseCase {
    // TODO: 모든 UseCase 리턴 타입에 옵셔널 제거
    func execute(videoId: Int) -> Observable<SceneStealerResult?>
}
