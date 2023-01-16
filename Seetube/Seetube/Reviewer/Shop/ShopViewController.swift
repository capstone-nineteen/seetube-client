//
//  ShopViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/16.
//

import UIKit

class ShopViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureGradientBackground()
    }
}

extension ShopViewController {
    private func configureGradientBackground() {
        guard let accentColor = UIColor(named: "AccentColor") else { return }
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [accentColor.cgColor, UIColor.white.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = self.view.bounds
        self.view.layer.insertSublayer(gradient, at: 0)
    }
}
