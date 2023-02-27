//
//  TextFieldJoinable.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import UIKit
import RxCocoa
import RxSwift

protocol TextFieldJoinable: UIViewController {
    func joinTextFields(_ textFields: [UITextField?]) -> Disposable
}

extension TextFieldJoinable {
    func joinTextFields(_ textFields: [UITextField?]) -> Disposable {
        let finishedTextFieldTag = textFields
            .compactMap { $0 }
            .map { textField in
                textField.rx
                    .controlEvent(.editingDidEndOnExit)
                    .asDriver()
                    .map { textField.tag }
            }
        
        return Driver
            .merge(finishedTextFieldTag)
            .drive(with: self) { obj, tag in
                guard let nextTextField = obj.view.viewWithTag(tag + 1)
                        as? UITextField else { return }
                nextTextField.becomeFirstResponder()
            }
    }
}
