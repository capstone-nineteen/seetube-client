//
//  EmotionResultPushable.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/08.
//

import Foundation

protocol EmotionResultPushable: ViewControllerPushable {
    func pushEmotionResult(videoId: Int)
}

extension EmotionResultPushable {
    func pushEmotionResult(videoId: Int) {
        self.push(
            viewControllerType: EmotionResultViewController.self
        ) { viewController in
            let repository = DefaultEmotionResultRepository()
            let fetchEmotionResultUseCase = DefaultFetchEmotionResultUseCase(repository: repository)
            let viewModel = EmotionResultViewModel(videoId: videoId,
                                                   fetchEmotionResultUseCase: fetchEmotionResultUseCase)
            viewController.viewModel = viewModel
        }
    }
}

