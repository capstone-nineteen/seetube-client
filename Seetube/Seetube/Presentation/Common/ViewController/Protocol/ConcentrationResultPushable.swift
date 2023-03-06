//
//  ConcentrationResultPushable.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/06.
//

import Foundation

protocol ConcentrationResultPushable: ViewControllerPushable {
    func pushConcentrationResult(videoId: Int)
}

extension ConcentrationResultPushable {
    func pushConcentrationResult(videoId: Int) {
        self.push(
            viewControllerType: ConcentrationResultViewController.self
        ) { viewController in
            let repository = DefaultConcentrationResultRepository()
            let fetchConcentrationResultUseCase = DefaultFetchConcentrationResultUseCase(repository: repository)
            let viewModel = ConcentrationResultViewModel(videoId: videoId,
                                                         fetchConcentrationResultUseCase: fetchConcentrationResultUseCase)
            viewController.viewModel = viewModel
        }
    }
}
