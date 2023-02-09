//
//  CategoryButtonStackView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit

class CategoryButtonStackView: UIStackView {
    var categoryButtons: [CategoryButton] = Category.allCases.map{ CategoryButton(category: $0) }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureSubviews()
        self.configureStyle()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.configureSubviews()
        self.configureStyle()
    }
    
    private func configureSubviews() {
        self.categoryButtons.forEach{ self.addArrangedSubview($0) }
    }
    
    private func configureStyle() {
        self.spacing = 8
    }
    
    func categoryButtonWithCategory(_ category: Category) -> CategoryButton? {
        return self.categoryButtons.first(where: { $0.category == category })
    }
    
    func highlightButton(category: Category) {
        self.categoryButtons.forEach { $0.backgroundColor = .white }
        self.categoryButtonWithCategory(category)?.backgroundColor = .systemGray5
    }
    
    func configureButtonDelegate(_ delegate: CategoryButtonDelegate) {
        self.categoryButtons.forEach { $0.configureDelegate(delegate) }
    }
}
