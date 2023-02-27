//
//  SignUpViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/27.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController,
                            KeyboardDismissible
{
    @IBOutlet weak var nicknameTextField: UnderLineTextField!
    @IBOutlet weak var emailTextField: UnderLineTextField!
    @IBOutlet weak var verificationCodeTextField: UnderLineTextField!
    @IBOutlet weak var passwordTextField: UnderLineTextField!
    @IBOutlet weak var passwordConfirmTextField: UnderLineTextField!
    @IBOutlet weak var nicknameValidationLabel: UILabel!
    @IBOutlet weak var emailValidationLabel: UILabel!
    @IBOutlet weak var verificationCodeValidationLabel: UILabel!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    @IBOutlet weak var passwordConfirmValidationLabel: UILabel!
    @IBOutlet weak var verificationCodeRequestButton: UIButton!
    @IBOutlet weak var signUpButton: BottomButton!
    
    var coverView = UIView()
    
    // TODO: 뷰모델
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
}

// MARK: - Configuration

extension SignUpViewController {
    private func configureUI() {
        self.enableKeyboardDismissing()
        self.configureTextFields()
    }
    
    private func configureTextFields() {
        let textFields = [self.nicknameTextField,
                          self.emailTextField,
                          self.verificationCodeTextField,
                          self.passwordTextField,
                          self.passwordConfirmTextField]
        let finishedTextFieldTag = textFields
            .compactMap { $0 }
            .map { textField in
                textField.rx
                    .controlEvent(.editingDidEndOnExit)
                    .asDriver()
                    .map { textField.tag }
            }
        
        Driver
            .merge(finishedTextFieldTag)
            .drive(with: self) { obj, tag in
                guard let nextTextField = obj.view.viewWithTag(tag + 1)
                        as? UITextField else { return }
                nextTextField.becomeFirstResponder()
            }
            .disposed(by: self.disposeBag)
    }
}
