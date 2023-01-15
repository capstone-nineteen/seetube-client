//
//  ResultMenuButton.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/11.
//

import UIKit

@IBDesignable
class ResultMenuButton: UIButton, NibLoadable {
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBInspectable var title: String?
    @IBInspectable var iconImageName: String?
    @IBInspectable var color: UIColor?
    
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
        
        self.gradientView.startColor = self.color
        self.gradientView.endColor = self.color?.withAlphaComponent(0.5)
        self.menuTitleLabel.text = self.title
        self.iconImageView.tintColor = self.color
        if let iconImage = iconImageName {
            self.iconImageView.image = UIImage(systemName: iconImage)
        } else {
            self.iconImageView.image = nil
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.alpha = isHighlighted ? 0.7 : 1.0
        }
    }
    
    private func configureShadow() {
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 2, height: 4)
        self.layer.shadowRadius = 3
        self.layer.masksToBounds = false
    }
}
