//
//  CategoryButtonScrollView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit

@IBDesignable
class CategoryButtonScrollView: UIScrollView {
    private lazy var categoryButtonStackView = CategoryButtonStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureSubviews()
    }
    
    private func configureSubviews() {
        self.addSubview(self.categoryButtonStackView)
        self.categoryButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.categoryButtonStackView.leadingAnchor.constraint(equalTo: self.contentLayoutGuide.leadingAnchor),
            self.categoryButtonStackView.bottomAnchor.constraint(equalTo: self.contentLayoutGuide.bottomAnchor),
            self.categoryButtonStackView.trailingAnchor.constraint(equalTo: self.contentLayoutGuide.trailingAnchor),
            self.categoryButtonStackView.topAnchor.constraint(equalTo: self.contentLayoutGuide.topAnchor),
            self.categoryButtonStackView.heightAnchor.constraint(equalTo: self.frameLayoutGuide.heightAnchor)
        ])
    }
    
    private func centerCategory(_ category: Category) {
        guard let button = self.categoryButtonStackView.categoryButtonWithCategory(category) else { return }
        
        let maximumXOffset = self.categoryButtonStackView.bounds.width - self.bounds.width
        let buttonCenterXOffset = button.frame.midX - self.bounds.width / 2
        UIView.animate(withDuration: 0.1, delay: 0) {
            self.contentOffset = CGPoint(x: min(maximumXOffset, max(0, buttonCenterXOffset)), y: 0)
        }
    }
    
    func highlightCategory(category: Category) {
        self.categoryButtonStackView.highlightButton(category: category)
        self.centerCategory(category)
    }
    
    func configureButtonDelegate(_ delegate: CategoryButtonDelegate) {
        self.categoryButtonStackView.configureButtonDelegate(delegate)
    }
}
