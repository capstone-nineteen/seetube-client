//
//  ActionDisabledTextField.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/17.
//

import UIKit

class ActionDisabledTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        switch action {
        case #selector(UIResponderStandardEditActions.paste(_:)),
             #selector(UIResponderStandardEditActions.select(_:)),
             #selector(UIResponderStandardEditActions.selectAll(_:)),
             #selector(UIResponderStandardEditActions.copy(_:)),
             #selector(UIResponderStandardEditActions.cut(_:)),
             #selector(UIResponderStandardEditActions.delete(_:)):
            return false
        default:
            return super.canPerformAction(action, withSender: sender)
        }
    }
}
