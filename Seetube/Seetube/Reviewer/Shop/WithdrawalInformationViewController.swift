//
//  WithdrawalInformationViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/18.
//

import UIKit

class WithdrawalInformationViewController: UIViewController {
    @IBOutlet weak var bankNameTextField: UnderLineTextField!
    @IBOutlet weak var accountHolderTextField: UnderLineTextField!
    @IBOutlet weak var accountNumberTextField: UnderLineTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func accountNumberEditingChanged(_ sender: UITextField) {
        sender.text = sender.text?.filter { $0.isNumber }
    }
}

extension WithdrawalInformationViewController {
    private func configureTextField() {
        self.bankNameTextField.delegate = self
        self.accountHolderTextField.delegate = self
        self.accountNumberTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tap)
    }
}

extension WithdrawalInformationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return false
    }
}
