//
//  AdaptiveFontSizeLabel.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/17.
//

import UIKit

class AdaptiveFontSizeLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    private func configure() {
        self.font = UIFont.systemFont(ofSize: 100)
        self.minimumScaleFactor = 0.01
        self.adjustsFontSizeToFitWidth = true
        self.lineBreakMode = .byClipping
        self.numberOfLines = 0
    }
    
    func setWeight(_ weight: UIFont.Weight) {
        self.font = UIFont.systemFont(ofSize: 100, weight: weight)
    }
}
