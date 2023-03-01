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
                            TextFieldJoinable,
                            AlertDisplaying,
                            YoutuberStartable,
                            ReviewerStartable
{
    @IBOutlet weak var emailTextField: UnderLineTextField!
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
        let textFields = [self.emailTextField, self.pwTextField]
        self.joinTextFields(textFields)
            .disposed(by: self.disposeBag)
    }
}

// MARK: - ViewModel Binding

extension SignInViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let signUpButtonTouched = self.signUpButtonTouchedEvent()
        let email = self.emailProperty()
        let password = self.passwordProperty()
        let signInButtonTouched = self.signInButtonTouchedEvent()
        
        let input = SignInViewModel.Input(signUpButtonTouched: signUpButtonTouched,
                                          email: email,
                                          password: password,
                                          signInButtonTouched: signInButtonTouched)
        let output = viewModel.transform(input: input)
        
        self.bindShoudlMoveToSignUp(output.shouldMoveToSignUp)
        self.bindSignInSucceed(output.signInSucceed)
        self.bindSignInFailed(output.signInFailed)
    }
    
    // MARK: Input Event Creation
    
    private func signUpButtonTouchedEvent() -> Driver<Void> {
        return self.signUpButton.rx.tap.asDriver()
    }
    
    private func emailProperty() -> Driver<String> {
        return self.emailTextField.rx.text.orEmpty.asDriver()
    }
    
    private func passwordProperty() -> Driver<String> {
        return self.pwTextField.rx.text.orEmpty.asDriver()
    }
    
    private func signInButtonTouchedEvent() -> Driver<Void> {
        return self.signInButton.rx.tap.asDriver()
    }
    
    // MARK: Output Binding
    
    private func bindShoudlMoveToSignUp(_ userType: Driver<UserType>) {
        userType
            .drive(with: self) { obj, userType in
                obj.pushSignUp(userType: userType)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindSignInSucceed(_ userType: Driver<UserType>) {
        userType
            .drive(with: self) { obj, userType in
                switch userType {
                case .reviewer:
                    obj.startAsReviewer()
                case .youtuber:
                    obj.startAsYoutuber()
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindSignInFailed(_ failed: Driver<Void>) {
        failed
            .drive(with: self) { obj, _ in
                obj.displaySignInFailedAlert()
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Alerts

extension SignInViewController {
    private func displaySignInFailedAlert() {
        self.displayFailureAlert(
            message: "로그인에 실패하였습니다. 이메일과 비밀번호를 다시 확인하세요."
        )
    }
}
