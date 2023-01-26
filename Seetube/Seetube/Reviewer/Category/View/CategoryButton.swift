//
//  CategoryButton.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit

@IBDesignable
class CategoryButton: UIButton, NibLoadable {
    var category: Category?
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
        self.configureStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadFromNib(owner: self)
        self.configureStyle()
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
}
