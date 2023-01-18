//
//  WithdrawlCoinTextField.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/18.
//

import UIKit

@IBDesignable
class WithdrawlCoinTextField: UnderLineTextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureActions()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureActions()
    }
    
    private func configureActions() {
        self.isPasteEnabled = false
    }
}
