//
//  WithdrawlCoinTextField.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/18.
//

import UIKit

@IBDesignable
class NotPastableUnderLineTextField: UnderLineTextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        switch action {
        case #selector(UIResponderStandardEditActions.paste(_:)):
            return false
        default:
            return super.canPerformAction(action, withSender: sender)
        }
    }
}
