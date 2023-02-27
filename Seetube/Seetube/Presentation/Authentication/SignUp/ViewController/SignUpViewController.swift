//
//  SignUpViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/27.
//

import UIKit

class SignUpViewController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
