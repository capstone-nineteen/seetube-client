//
//  ShortsResultPushable.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/13.
//

import Foundation

protocol ShortsResultPushable: ViewControllerPushable {
    func pushShortsResult(videoId: Int)
}

extension ShortsResultPushable {
    func pushShortsResult(videoId: Int) {
        self.push(
            viewControllerType: ShortsResultViewController.self
        ) { viewController in
            let repository = DefaultShortsResultRepository()
            let fetchShortsResultUseCase = DefaultFetchShortsResultUseCase(repository: repository)
            let viewModel = ShortsResultViewModel(videoId: videoId,
                                                  fetchShortsResultUseCase: fetchShortsResultUseCase)
            viewController.viewModel = viewModel
        }
    }
}
