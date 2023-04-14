//
//  WatchPushable.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/18.
//

import Foundation

protocol WatchPresentable: ViewControllerPresentable {
    func presentWatch(url: String, videoId: Int)
}

extension WatchPresentable {
    func presentWatch(url: String, videoId: Int) {
        self.present(
            viewControllerType: WatchViewController.self
        ) { viewController in
            let repository = DefaultReviewRepository()
            let submitReviewUseCase = DefaultSubmitReviewUseCase(repository: repository)
            let checkAbusingUseCase = DefaultCheckAbusingUseCase()
            let viewModel = WatchViewModel(submitReviewUseCase: submitReviewUseCase,
                                           checkAbusingUseCase: checkAbusingUseCase,
                                           url: url,
                                           videoId: videoId)
            viewController.viewModel = viewModel
        }
    }
}
