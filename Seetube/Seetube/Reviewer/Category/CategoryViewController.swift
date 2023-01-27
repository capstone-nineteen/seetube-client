//
//  CategoryViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit

enum Category: String, CaseIterable {
    case all = "전체"
    case game = "게임"
    case entertainment = "엔터테인먼트"
    case beauty = "뷰티"
    case sports = "스포츠"
    case daily = "일상"
    case music = "음악"
    case etc = "기타"
}

class CategoryViewController: UIViewController {
    @IBOutlet weak var categoryButtons: CategoryButtonScrollView!
    
    private var selectedCategory: Category = .all {
        didSet { self.categoryButtons.highlightCategory(category: self.selectedCategory) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCategoryButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func configureCategoryButtons() {
        self.categoryButtons.configureButtonDelegate(self)
        self.selectedCategory = .all
    }
}

extension CategoryViewController: CategoryButtonDelegate {
    func categoryButtonTouched(_ sender: CategoryButton) {
        guard let buttonCategory = sender.category else { return }
        self.selectedCategory = buttonCategory
    }
}
