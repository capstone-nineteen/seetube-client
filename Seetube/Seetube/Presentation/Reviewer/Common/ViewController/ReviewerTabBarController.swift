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
        self.configureChildViewControllers()
    }
}

// MARK: - Configuration

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
    
    private func configureChildViewControllers() {
        guard let viewControllers = self.viewControllers else { return }
        
        for viewController in viewControllers {
            var childViewController: UIViewController?

            if let navigationController = viewController as? UINavigationController {
                childViewController = navigationController.viewControllers.first
            } else {
                childViewController = viewController
            }

            switch childViewController {
            case let reviewerHomeViewController as ReviewerHomeViewController:
                let repository = DefaultReviewerHomeRepository()
                let fetchReviewerHomeUseCase = DefaultFetchReviewerHomeUseCase(repository: repository)
                let viewModel = ReviewerHomeViewModel(fetchReviewerHomeUseCase: fetchReviewerHomeUseCase)
                reviewerHomeViewController.viewModel = viewModel
            case let videosByCategoryViewController as VideosByCategoryViewController:
                let repository = DefaultVideosByCategoryRepository()
                let fetchVideosByCategoryUseCase = DefaultFetchVideosByCategoryUseCase(repository: repository)
                let viewModel = VideosByCategoryViewModel(fetchVideosByCategoryUseCase: fetchVideosByCategoryUseCase)
                videosByCategoryViewController.viewModel = viewModel
            case let shopViewController as ShopViewController:
                let repository = DefaultShopRepository()
                let fetchTotalCoinAmountUseCase = DefaultFetchTotalCoinAmountUseCase(repository: repository)
                let viewModel = ShopViewModel(fetchTotalCoinAmountUseCase: fetchTotalCoinAmountUseCase)
                shopViewController.viewModel = viewModel
            case let myPageViewController as MyPageViewController:
                let repository = DefaultMyPageRepository()
                let fetchMyPageUseCase = DefaultFetchMyCaseUseCase(repository: repository)
                let viewModel = MyPageViewModel(fetchMyPageUseCase: fetchMyPageUseCase)
                myPageViewController.viewModel = viewModel
            default:
                break
            }
        }
    }
}
