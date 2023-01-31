//
//  CircularProgressBar.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/13.
//

import UIKit

class CircularProgressBar: UIView {
    var lineWidth: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        let bezierPath = UIBezierPath()
        bezierPath.addArc(withCenter: CGPoint(x: rect.midX, y: rect.midY),
                          radius: rect.midX - (self.lineWidth / 2),
                          startAngle: 0,
                          endAngle: .pi * 2,
                          clockwise: true)
        bezierPath.lineWidth = self.lineWidth
        Colors.progressBarGray.set()
        bezierPath.stroke()
    }
    
    func setProgress(value: Double, text: String, color: UIColor?) {
        self.subviews.forEach { $0.removeFromSuperview() }
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        let bezierPath = UIBezierPath()
        bezierPath.addArc(withCenter: CGPoint(x: self.bounds.midX, y: self.bounds.midY),
                          radius: self.bounds.midX - (lineWidth / 2),
                          startAngle: -.pi / 2,
                          endAngle: ((.pi * 2) * value) - (.pi / 2),
                          clockwise: true)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.lineCap = .round
        shapeLayer.strokeColor = color?.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth
        self.layer.addSublayer(shapeLayer)

        let label = UILabel()
        label.text = text
        label.textColor = .label
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 2
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
