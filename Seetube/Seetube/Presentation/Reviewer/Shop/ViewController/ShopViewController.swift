//
//  ShopViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/16.
//

import UIKit

class ShopViewController: UIViewController, ViewControllerPushable {
    @IBOutlet weak var receiptView: ReceiptView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDelegate()
        self.configureKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension ShopViewController {
    private func configureDelegate() {
        self.receiptView.configureButtonDelegate(self)
        self.receiptView.configureTextFieldDelegate(self)
    }
    
    private func configureKeyboard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension ShopViewController {
    @objc private func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150
    }
    
    @objc private func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
}

extension ShopViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = textField.text == "" ? "0" : textField.text
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldString = textField.text,
              let newRange = Range(range, in: oldString) else { return true }
        
        let newString = oldString.replacingCharacters(in: newRange, with: string)
        let textWithoutSeparator = newString.replacingOccurrences(of: ",", with: "")
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        if let numberWithSeparator = formatter.number(from: textWithoutSeparator) {
            textField.text = formatter.string(from: numberWithSeparator)
            return false
        }
        
        return true
    }
}

extension ShopViewController: WithdrawButtonDelegate {
    func withdrawButtonTouched(_ sender: BottomButton) {
        self.push(viewControllerType: WithdrawalInformationViewController.self)
    }
}
