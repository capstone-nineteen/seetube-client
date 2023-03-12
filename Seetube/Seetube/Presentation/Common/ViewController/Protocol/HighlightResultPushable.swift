//
//  HighlightResultPushable.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/13.
//

import Foundation

protocol HighlightResultPushable: ViewControllerPushable {
    func pushHighlightResult(videoId: Int)
}

extension HighlightResultPushable {
    func pushHighlightResult(videoId: Int) {
        self.push(
            viewControllerType: HighlightResultViewController.self
        ) { viewController in
            let repository = DefaultHighlightResultRepository()
            let fetchHighlightResultUseCase = DefaultFetchHighlightResultUseCase(repository: repository)
            let viewModel = HighlightResultViewModel(videoId: videoId,
                                                     fetchHighlightResultUseCase: fetchHighlightResultUseCase)
            viewController.viewModel = viewModel
        }
    }
}
