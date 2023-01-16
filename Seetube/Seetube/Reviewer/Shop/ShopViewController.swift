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
        guard let accentColor = UIColor(named: "AccentColor")?.cgColor else { return }
        self.view.layer.makeGradientBackground(colors: [accentColor, UIColor.white.cgColor],
                                               locations: [0.0, 1.0],
                                               startPoint: CGPoint(x: 0.0, y: 0.0),
                                               endPoint: CGPoint(x: 0.0, y: 1.0),
                                               type: .axial)
    }
}
