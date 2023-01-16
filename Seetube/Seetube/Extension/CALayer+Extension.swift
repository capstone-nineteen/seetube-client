//
//  CALayer+Extension.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/16.
//

import UIKit

extension CALayer {
    func applyShadow(color: UIColor, alpha: Float, x: CGFloat, y: CGFloat, radius: CGFloat) {
        self.shadowColor = color.cgColor
        self.shadowOpacity = alpha
        self.shadowOffset = CGSize(width: x, height: y)
        self.shadowRadius = radius
        self.masksToBounds = false
    }
}
