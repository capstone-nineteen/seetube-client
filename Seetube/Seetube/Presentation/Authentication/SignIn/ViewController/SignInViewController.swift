//
//  SignInViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/14.
//

import UIKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController,
                            SignUpPushable,
                            TextFieldJoinable
{
    @IBOutlet weak var idTextField: UnderLineTextField!
    @IBOutlet weak var pwTextField: UnderLineTextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: BottomButton!
    
    var viewModel: SignInViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
}

// MARK: - Configuration

extension SignInViewController {
    private func configureUI() {
        self.configureSignUpButton()
        self.configureTextFields()
    }
    
    private func configureSignUpButton() {
        self.signUpButton.rx.tap
            .asDriver()
            .drive(with: self) { obj, _ in
                // TODO: userType 전달
                obj.pushSignUp(userType: .youtuber)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func configureTextFields() {
        let textFields = [self.idTextField, self.pwTextField]
        self.joinTextFields(textFields)
            .disposed(by: self.disposeBag)
    }
}
