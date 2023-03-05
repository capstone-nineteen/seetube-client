//
//  YoutuberVideoDetailPushable.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/05.
//

import Foundation

protocol YoutuberVideoDetailPushable: ViewControllerPushable {
    func pushYoutuberVideoDetail(videoId: Int)
}

extension YoutuberVideoDetailPushable {
    func pushYoutuberVideoDetail(videoId: Int) {
        self.push(
            viewControllerType: YoutuberVideoDetailViewController.self
        ) { viewController in
            let repository = DefaultVideoDetailRepository()
            let fetchVideoDetailUseCase = DefaultFetchVideoDetailUseCase(repository: repository)
            let viewModel = YoutuberVideoDetailViewModel(fetchVideoInfoUseCase: fetchVideoDetailUseCase,
                                                         videoId: videoId)
            viewController.viewModel = viewModel
        }
    }
}
