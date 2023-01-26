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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var categoryStackView: UIStackView!
    private var categoryButtons: [CategoryButton] = []
    
    private var selectedCategory: Category = .all {
        didSet { self.highlightCategory(self.selectedCategory) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCategoryStackView()
    }
    
    private func configureCategoryStackView() {
        self.categoryButtons = Category.allCases.map { category in
            let button = CategoryButton(category: category)
            button.addAction(UIAction(handler: { [weak self] _ in self?.selectedCategory = category }),
                             for: .touchUpInside)
            return button
        }
        self.categoryButtons.forEach { self.categoryStackView.addArrangedSubview($0) }
        self.selectedCategory = .all
    }
}

extension CategoryViewController {
    private func highlightCategory(_ category: Category) {
        for button in self.categoryButtons {
            if button.category == category {
                button.backgroundColor = .systemGray5
                self.centerCategoryButtonInScrollView(button)
            } else {
                button.backgroundColor = .white
            }
        }
    }
    
    private func centerCategoryButtonInScrollView(_ button: CategoryButton) {
        let maximumXOffset = self.categoryStackView.bounds.width - self.scrollView.bounds.width
        let buttonCenterXOffset = button.frame.midX - self.scrollView.bounds.width / 2
        
        UIView.animate(withDuration: 0.1, delay: 0) {
            self.scrollView.contentOffset = CGPoint(x: min(maximumXOffset, max(0, buttonCenterXOffset)), y: 0)
        }
    }
}
