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
                            KeyboardDismissible,
                            TextFieldJoinable
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
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var signUpButton: BottomButton!
    
    var coverView = UIView()
    
    var viewModel: SignUpViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
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
        self.joinTextFields(textFields)
            .disposed(by: self.disposeBag)
    }
}

// MARK: - ViewModel Binding

extension SignUpViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let nickname = self.nicknameProperty()
            .debug("vc nickname")
        let email = self.emailProperty()
        let verificationCode = self.verificationCodeProperty()
        let password = self.passwordProperty()
        let passwordConfirm = self.passwordConfirmProperty()
        let requestButtonTouched = self.requestButtonTouchedEvent()
        let signUpButtonTouched = self.signUpButtonTouchedEvent()
        
        let input = SignUpViewModel.Input(nickname: nickname,
                                          email: email,
                                          verificationCode: verificationCode,
                                          password: password,
                                          passwordConfirm: passwordConfirm,
                                          requestButtonTouched: requestButtonTouched,
                                          signUpButtonTouched: signUpButtonTouched)
        let output = viewModel.transform(input: input)
        
        self.bindNicknameValidationResult(output.nicknameValidationResult)
        self.bindEmailValidationResult(output.emailValidationResult)
        self.bindVerificationCodeRequestResult(output.verificationCodeRequestResult)
        self.bindVerificationCodeValidationResult(output.verificationCodeValidationResult)
        self.bindPasswordValidationResult(output.passwordValidationResult)
        self.bindPasswordConfirmValidationResult(output.passwordConfirmValidationResult)
        self.bindFinalValidationResult(output.finalValidationResult)
    }
    
    // MARK: Input Event Creation
    
    private func nicknameProperty() -> Driver<String> {
        return self.nicknameTextField.rx.text.orEmpty.asDriver()
    }
    
    private func emailProperty() -> Driver<String> {
        return self.emailTextField.rx.text.orEmpty.asDriver()
    }
    
    private func verificationCodeProperty() -> Driver<String> {
        return self.verificationCodeTextField.rx.text.orEmpty.asDriver()
    }
    
    private func passwordProperty() -> Driver<String> {
        return self.passwordTextField.rx.text.orEmpty.asDriver()
    }
    
    private func passwordConfirmProperty() -> Driver<String> {
        return self.passwordConfirmTextField.rx.text.orEmpty.asDriver()
    }
    
    private func requestButtonTouchedEvent() -> Driver<Void> {
        return self.verificationCodeRequestButton.rx.tap.asDriver()
    }
    
    private func signUpButtonTouchedEvent() -> Driver<Void> {
        return self.signUpButton.rx.tap.asDriver()
    }
    
    // MARK: Output Binding
    
    private func bindNicknameValidationResult(_ result: Driver<SignUpValidationResult>) {
        result
            .mapToColor()
            .drive(self.nicknameValidationLabel.rx.textColor)
            .disposed(by: self.disposeBag)
        
        result
            .map { $0.message }
            .drive(self.nicknameValidationLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
    
    private func bindEmailValidationResult(_ result: Driver<SignUpValidationResult>) {
        result
            .mapToColor()
            .drive(self.emailValidationLabel.rx.textColor)
            .disposed(by: self.disposeBag)
        
        result
            .map { $0.message }
            .drive(self.emailValidationLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        result
            .map { $0.isValid }
            .drive(self.verificationCodeRequestButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
    }
    
    private func bindVerificationCodeRequestResult(_ result: Driver<SignUpValidationResult>) {
        result
            .mapToColor()
            .drive(self.emailValidationLabel.rx.textColor)
            .disposed(by: self.disposeBag)
        
        result
            .map { $0.message }
            .drive(self.emailValidationLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
    
    private func bindVerificationCodeValidationResult(_ result: Driver<SignUpValidationResult>) {
        result
            .mapToColor()
            .drive(self.verificationCodeValidationLabel.rx.textColor)
            .disposed(by: self.disposeBag)
        
        result
            .map { $0.message }
            .drive(self.verificationCodeValidationLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
    
    private func bindPasswordValidationResult(_ result: Driver<SignUpValidationResult>) {
        result
            .mapToColor()
            .drive(self.passwordValidationLabel.rx.textColor)
            .disposed(by: self.disposeBag)
        
        result
            .map { $0.message }
            .drive(self.passwordValidationLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
    
    private func bindPasswordConfirmValidationResult(_ result: Driver<SignUpValidationResult>) {
        result
            .mapToColor()
            .drive(self.passwordConfirmValidationLabel.rx.textColor)
            .disposed(by: self.disposeBag)
        
        result
            .map { $0.message }
            .drive(self.passwordConfirmValidationLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
    
    private func bindFinalValidationResult(_ result: Driver<Bool>) {
        result
            .debug("final result")
            .drive(self.signUpButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
    }
}
