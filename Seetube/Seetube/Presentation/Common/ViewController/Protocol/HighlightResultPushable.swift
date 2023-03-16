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
            let highlightResultRepository = DefaultHighlightResultRepository()
            let photoAlbumRepository = DefaultPhotoAlbumRepository()
            
            let fetchHighlightResultUseCase = DefaultFetchHighlightResultUseCase(repository: highlightResultRepository)
            let saveVideoUseCase = DefaultSaveVideoUseCase(repository: photoAlbumRepository)
            let downloadVideoUseCase = DefaultDownloadVideoUseCase()
            
            let viewModel = HighlightResultViewModel(videoId: videoId,
                                                     fetchHighlightResultUseCase: fetchHighlightResultUseCase,
                                                     downloadVideoUseCase: downloadVideoUseCase,
                                                     saveVideoUseCase: saveVideoUseCase)
            viewController.viewModel = viewModel
        }
    }
}
