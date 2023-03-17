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
            let shortsResultRepository = DefaultShortsResultRepository()
            let photoAlbumRepository = DefaultPhotoAlbumRepository()
            
            let fetchShortsResultUseCase = DefaultFetchShortsResultUseCase(repository: shortsResultRepository)
            let downloadVideoUseCase = DefaultDownloadVideoUseCase()
            let saveVideoUseCase = DefaultSaveVideoUseCase(repository: photoAlbumRepository)
            
            let viewModel = ShortsResultViewModel(videoId: videoId,
                                                  fetchShortsResultUseCase: fetchShortsResultUseCase,
                                                  downloadVideoUseCase: downloadVideoUseCase,
                                                  saveVideoUseCase: saveVideoUseCase)
            viewController.viewModel = viewModel
        }
    }
}
