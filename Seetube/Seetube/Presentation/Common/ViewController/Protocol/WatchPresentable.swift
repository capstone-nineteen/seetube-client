//
//  WatchPushable.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/18.
//

import Foundation

protocol WatchPresentable: ViewControllerPresentable {
    func presentWatch(with url: String)
}

extension WatchPresentable {
    func presentWatch(with url: String) {
        self.present(
            viewControllerType: VideoPlayerViewController.self
        ) { viewController in
            let viewModel = VideoPlayerViewModel(url: url)
            viewController.viewModel = viewModel
        }
    }
}
