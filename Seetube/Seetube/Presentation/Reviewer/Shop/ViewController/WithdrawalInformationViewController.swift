//
//  WithdrawalInformationViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/18.
//

import UIKit

class WithdrawalInformationViewController: UIViewController, AlertDisplaying {
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
    
    @IBAction func applyButtonTouched(_ sender: UIButton) {
        self.displayAlertWithAction(title: "환급 신청", message: "입력하신 정보가 올바른지 확인하십시오. 해당 정보로 환급을 신청하시겠습니까?", action: { [weak self] _ in
            self?.displayApplicationCompeleteAlert()
        })
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

extension WithdrawalInformationViewController {
    private func displayApplicationCompeleteAlert() {
        self.displayAlertWithAction(title: "신청 완료",
                                    message: "환급 신청이 완료되었습니다.",
                                    action: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
    }
}
