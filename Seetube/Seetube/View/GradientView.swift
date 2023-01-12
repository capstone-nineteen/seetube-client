//
//  GradientView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/11.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    var startColor: UIColor?
    var endColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        layer.sublayers?.first?.removeFromSuperlayer()
        
        guard let startColor = self.startColor,
              let endColor = self.endColor else { return }
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = bounds
        gradient.cornerRadius = layer.cornerRadius
        layer.addSublayer(gradient)
    }
}
