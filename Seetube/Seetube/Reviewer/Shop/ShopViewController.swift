//
//  ShopViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/16.
//

import UIKit

class ShopViewController: UIViewController {
    @IBOutlet weak var receiptView: UIImageView!
    private lazy var totalCoinLabel: UILabel = {
        let label = UILabel()
        label.text = "12,500"
        label.font = UIFont.systemFont(ofSize: 100, weight: .bold)
        label.textAlignment = .right
        label.minimumScaleFactor = 0.01
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureGradientBackground()
        self.configureSubviews()
    }
}

extension ShopViewController {
    private func configureGradientBackground() {
        guard let accentColor = UIColor(named: "AccentColor")?.cgColor else { return }
        self.view.layer.makeGradientBackground(colors: [accentColor, UIColor.white.cgColor],
                                               locations: [0.0, 1.0],
                                               startPoint: CGPoint(x: 0.0, y: 0.0),
                                               endPoint: CGPoint(x: 0.0, y: 1.0),
                                               type: .axial)
    }
    
    private func configureSubviews() {
        // TODO: total coin label 옆에 별사탕 이미지는 뷰로 구현하도록 수정
        self.receiptView.addSubview(self.totalCoinLabel)
        self.totalCoinLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.totalCoinLabel,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: self.receiptView,
                               attribute: .trailing,
                               multiplier: 0.75,
                               constant: 0),
            NSLayoutConstraint(item: self.totalCoinLabel,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: self.receiptView,
                               attribute: .trailing,
                               multiplier: 0.38,
                               constant: 0),
            NSLayoutConstraint(item: self.totalCoinLabel as Any,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: self.receiptView,
                               attribute: .bottom,
                               multiplier: 0.44,
                               constant: 0),
            self.totalCoinLabel.heightAnchor.constraint(equalTo: self.receiptView.heightAnchor, multiplier: 0.1)
        ])
    }
}
