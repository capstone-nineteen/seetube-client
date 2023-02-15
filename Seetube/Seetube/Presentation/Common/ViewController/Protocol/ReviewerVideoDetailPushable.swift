//
//  VideoDetailPushable.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/15.
//

import Foundation

protocol ReviewerVideoDetailPushable: ViewControllerPushable {
    func pushVideoDetail(videoId: Int)
}

extension ReviewerVideoDetailPushable {
    func pushVideoDetail(videoId: Int) {
        self.push(
            viewControllerType: ReviewerVideoDetailViewController.self
        ) { viewController in
            let repository = DefaultVideoDetailRepository()
            let fetchVideoInfoUseCase = DefaultFetchVideoDetailUseCase(repository: repository)
            let viewModel = ReviewerVideoDetailViewModel(
                fetchVideoInfoUseCase: fetchVideoInfoUseCase,
                videoId: videoId
            )
            viewController.viewModel = viewModel
        }
    }
}
