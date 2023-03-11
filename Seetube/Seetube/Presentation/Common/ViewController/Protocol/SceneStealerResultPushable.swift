//
//  SceneStealerResultPushable.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/12.
//

import Foundation

protocol SceneStealerResultPushable: ViewControllerPushable {
    func pushSceneStealerResult(videoId: Int)
}

extension SceneStealerResultPushable {
    func pushSceneStealerResult(videoId: Int) {
        self.push(
            viewControllerType: SceneStealerResultViewController.self
        ) { viewController in
            let repository = DefaultSceneStealerResultRepository()
            let fetchSceneStealerResultUseCase = DefaultFetchSceneStealerResultUseCase(repository: repository)
            let viewModel = SceneStealerResultViewModel(videoId: videoId,
                                                        fetchSceneStealerResultUseCase: fetchSceneStealerResultUseCase)
            viewController.viewModel = viewModel
        }
    }
}
