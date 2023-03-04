//
//  YoutuberNavigationController.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/05.
//

import UIKit

class YoutuberNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViewController()
    }
}

// MARK: - Configuration

extension YoutuberNavigationController {
    private func configureViewController() {
        guard let youtuberHomeViewController = self.viewControllers.first as? YoutuberHomeViewController else { return }
        
        let repository = DefaultYoutuberHomeRepository()
        let fetchYoutuberHomeUseCase = DefaultFetchYoutuberHomeUseCase(repository: repository)
        let viewModel = YoutuberHomeViewModel(fetchYoutuberHomeUseCase: fetchYoutuberHomeUseCase)
        youtuberHomeViewController.viewModel = viewModel
    }
}
