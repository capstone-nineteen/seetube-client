//
//  ReviewerTabBarController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/16.
//

import UIKit

class ReviewerTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTabBar()
        self.configureTabBarItems()
    }
}

extension ReviewerTabBarController {
    private func configureTabBar() {
        self.tabBar.layer.borderWidth = 0.2
        self.tabBar.layer.borderColor = UIColor.gray.cgColor
        self.tabBar.clipsToBounds = true
    }
    
    private func configureTabBarItems() {
        self.viewControllers?.forEach { viewController in
            let tabBarItem = viewController.tabBarItem
            tabBarItem?.image = tabBarItem?.image?.withBaselineOffset(fromBottom: 12.0)
        }
    }
}
