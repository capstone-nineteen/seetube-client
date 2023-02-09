//
//  CategoryViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit

class VideosByCategoryViewController: UIViewController {
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
        self.selectCategory(.all)
    }
}

extension VideosByCategoryViewController: CategoryButtonDelegate {
    func categoryButtonTouched(_ sender: CategoryButton) {
        guard let buttonCategory = sender.category else { return }
        self.selectCategory(buttonCategory)
    }
    
    func selectCategory(_ category: Category) {
        self.selectedCategory = category
    }
}
