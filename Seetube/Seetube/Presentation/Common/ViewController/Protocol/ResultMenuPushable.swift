//
//  ResultMenuPushable.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/05.
//

import Foundation

protocol ResultMenuPushable: ViewControllerPushable {
    func pushResultMenu(videoId: Int)
}

extension ResultMenuPushable {
    func pushResultMenu(videoId: Int) {
        self.push(
            viewControllerType: ResultMenuViewController.self
        ) { viewController in
            viewController.videoId = videoId
        }
    }
}
