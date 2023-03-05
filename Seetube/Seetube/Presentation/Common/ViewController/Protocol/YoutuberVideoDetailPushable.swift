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
            // TODO: 의존성 주입
        }
    }
}
