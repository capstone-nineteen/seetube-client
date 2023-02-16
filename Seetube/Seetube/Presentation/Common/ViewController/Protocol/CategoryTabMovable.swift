//
//  CategoryTabMovable.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/15.
//

import UIKit

protocol CategoryTabMovable: UIViewController {
    func moveToCategoryTab(category: Category)
}

extension CategoryTabMovable {
    func moveToCategoryTab(category: Category) {
        guard let tabBarController = self.navigationController?.tabBarController,
              let categoryNavigationController = tabBarController.viewControllers?[1]
                as? UINavigationController,
              let categoryViewController = categoryNavigationController.topViewController
                as? VideosByCategoryViewController else { return }
        
        let _ = categoryViewController.view // CategoryViewController 강제 로드
        categoryViewController.viewModel?.selectedCategory.accept(category)
        tabBarController.selectedIndex = 1
    }
}
