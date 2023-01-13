//
//  ResultMenuButton.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/11.
//

import UIKit

class CustomButton: UIButton { }

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
        loadFromNib(owner: self)
        configureShadow()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib(owner: self)
        configureShadow()
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
    
    private func configureShadow() {
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 2, height: 4)
        layer.shadowRadius = 3
        layer.masksToBounds = false
    }
}
