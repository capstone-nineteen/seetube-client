//
//  CustomAlertLoadingView.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/16.
//

import UIKit

@IBDesignable
class CustomAlertLoadingView: UIView, NibLoadable {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBInspectable var title: String? {
        get { self.titleLabel.text }
        set { self.titleLabel.text = newValue }
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
