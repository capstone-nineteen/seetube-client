//
//  SigninButton.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/15.
//

import UIKit

class SigninButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureShadow()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureShadow()
    }
    
    private func configureShadow() {
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 3
        self.layer.masksToBounds = false
    }
}
