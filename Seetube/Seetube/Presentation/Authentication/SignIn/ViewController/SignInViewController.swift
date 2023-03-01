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
        self.bindViewModel()
    }
}

// MARK: - Configuration

extension SignInViewController {
    private func configureUI() {
        self.configureTextFields()
    }
    
    private func configureTextFields() {
        let textFields = [self.idTextField, self.pwTextField]
        self.joinTextFields(textFields)
            .disposed(by: self.disposeBag)
    }
}

// MARK: - ViewModel Binding

extension SignInViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let signUpButtonTouched = self.signUpButtonTouchedEvent()
        
        let input = SignInViewModel.Input(signUpButtonTouched: signUpButtonTouched)
        let output = viewModel.transform(input: input)
        
        self.bindShoudlMoveToSignUp(output.shouldMoveToSignUp)
    }
    
    // MARK: Input Event Creation
    
    private func signUpButtonTouchedEvent() -> Driver<Void> {
        return self.signUpButton.rx.tap.asDriver()
    }
    
    // MARK: Output Binding
    
    private func bindShoudlMoveToSignUp(_ userType: Driver<UserType>) {
        userType
            .drive(with: self) { obj, userType in
                obj.pushSignUp(userType: userType)
            }
            .disposed(by: self.disposeBag)
    }
}
