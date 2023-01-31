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
        self.configureShadow(y: 2)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureShadow(y: 2)
    }
}
