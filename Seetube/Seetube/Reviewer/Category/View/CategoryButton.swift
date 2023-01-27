//
//  CategoryButton.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit

protocol CategoryButtonDelegate: AnyObject {
    func categoryButtonTouched(_ sender: CategoryButton)
}

class CategoryButton: UIButton, NibLoadable {
    var category: Category?
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    private weak var delegate: CategoryButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
        self.configureStyle()
        self.configureAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadFromNib(owner: self)
        self.configureStyle()
        self.configureAction()
    }
    
    convenience init(category: Category) {
        self.init(frame: CGRect())
        self.category = category
        self.categoryNameLabel.text = category.rawValue
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.categoryNameLabel.sizeToFit()
    }
    
    private func configureStyle() {
        self.clipsToBounds = true
        self.backgroundColor = .white
    }
    
    private func configureAction() {
        self.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.categoryButtonTouched(self)
        }), for: .touchUpInside)
    }
    
    func configureDelegate(_ delegate: CategoryButtonDelegate) {
        self.delegate = delegate
    }
}
