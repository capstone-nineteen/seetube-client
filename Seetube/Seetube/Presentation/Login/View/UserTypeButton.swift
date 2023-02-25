//
//  UserTypeButton.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/25.
//

import UIKit

@IBDesignable
class UserTypeButton: UIButton, NibLoadable {
    @IBOutlet var background: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userTypeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBInspectable
    var userDescription: String? {
        get { self.descriptionLabel.text }
        set { self.descriptionLabel.text = newValue }
    }
    
    @IBInspectable
    var userType: String? {
        get { self.userTypeLabel.text }
        set { self.userTypeLabel.text = newValue }
    }
    
    @IBInspectable
    var iconImage: UIImage? {
        get { self.iconImageView.image }
        set { self.iconImageView.image = newValue }
    }
    
    @IBInspectable
    override var backgroundColor: UIColor? {
        get { self.background.backgroundColor }
        set { self.background.backgroundColor = newValue }
    }
    
    @IBInspectable
    override var tintColor: UIColor? {
        get { self.userTypeLabel.textColor }
        set {
            self.userTypeLabel.textColor = newValue
            self.descriptionLabel.textColor = newValue
            self.iconImageView.tintColor = newValue
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadFromNib(owner: self)
    }
}
