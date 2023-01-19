//
//  UIView+Extension.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/11.
//

import UIKit

@IBDesignable
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        set { self.layer.cornerRadius = newValue }
        get { return self.layer.cornerRadius }
    }
    
    func configureShadow (
        color: UIColor = .black,
        alpha: Float = 0.25,
        x: CGFloat = 0,
        y: CGFloat = 4,
        radius: CGFloat = 3
    ) {
        self.layer.applyShadow(color: color, alpha: alpha, x: x, y: y, radius: radius)
    }
}
