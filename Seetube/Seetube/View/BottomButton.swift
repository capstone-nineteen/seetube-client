//
//  BottomButton.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/14.
//

import UIKit

@IBDesignable
class BottomButton: UIButton, NibLoadable {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBInspectable var name: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
        self.configureShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadFromNib(owner: self)
        self.configureShadow()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.nameLabel.text = self.name
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.alpha = isHighlighted ? 0.7 : 1.0
        }
    }
    
    private func configure() {
        self.configureShadow()
    }

    private func configureShadow() {
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 3
        self.layer.masksToBounds = false
    }
}
