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
                            TextFieldJoinable,
                            AlertDisplaying
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
    @IBOutlet weak var verificationButton: AlphaButton!
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
        let email = self.emailProperty()
        let verificationCode = self.verificationCodeProperty()
        let password = self.passwordProperty()
        let passwordConfirm = self.passwordConfirmProperty()
        let requestButtonTouched = self.requestButtonTouchedEvent()
        let signUpButtonTouched = self.signUpButtonTouchedEvent()
        let verificaionButtonTouched = self.verificationButtonTouchedEvent()
        
        let input = SignUpViewModel.Input(nickname: nickname,
                                          email: email,
                                          verificationCode: verificationCode,
                                          password: password,
                                          passwordConfirm: passwordConfirm,
                                          requestButtonTouched: requestButtonTouched,
                                          signUpButtonTouched: signUpButtonTouched,
                                          verificationButtonTouched: verificaionButtonTouched)
        let output = viewModel.transform(input: input)
        
        self.bindNicknameValidationResult(output.nicknameValidationResult)
        self.bindEmailValidationResult(output.emailValidationResult)
        self.bindVerificationCodeRequestResult(output.verificationCodeRequestResult)
        self.bindVerificationCodeValidationResult(output.verificationCodeValidationResult)
        self.bindRemainingVerificationTime(output.remainingVerificationTime)
        self.bindCanRequestVerificationCode(output.canRequestVerificationCode)
        self.bindCanVerify(output.canVerify)
        self.bindPasswordValidationResult(output.passwordValidationResult)
        self.bindPasswordConfirmValidationResult(output.passwordConfirmValidationResult)
        self.bindFinalValidationResult(output.finalValidationResult)
        self.bindSignUpResult(output.signUpResult)
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
    
    private func verificationButtonTouchedEvent() -> Driver<Void> {
        return self.verificationButton.rx.tap.asDriver()
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
            .map { $0.message }
            .drive(self.verificationCodeValidationLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
    
    private func bindCanRequestVerificationCode(_ canRequest: Driver<Bool>) {
        canRequest
            .drive(self.verificationCodeRequestButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        canRequest
            .drive(self.emailTextField.rx.isEnabled)
            .disposed(by: self.disposeBag)
    }
    
    private func bindCanVerify(_ canVerify: Driver<Bool>) {
        canVerify
            .drive(self.verificationButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        canVerify
            .drive(self.verificationCodeTextField.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        canVerify
            .filter { $0 }
            .drive(with: self) { obj, _ in
                obj.verificationCodeTextField.text = nil
                obj.verificationCodeValidationLabel.text = nil
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindRemainingVerificationTime(_ time: Driver<String?>) {
        time
            .drive(self.remainingTimeLabel.rx.text)
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
            .drive(self.signUpButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
    }
    
    private func bindSignUpResult(_ result: Driver<Bool>) {
        result
            .drive(with: self) { obj, success in
                if success {
                    obj.displaySignUpSucceedAlert()
                } else {
                    obj.displaySignUpFailedAlert()
                }
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Alerts

extension SignUpViewController {
    private func displaySignUpSucceedAlert() {
        self.displayAlertWithAction(
            title: "회원가입 완료",
            message: "회원가입이 완료되었습니다."
        ) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func displaySignUpFailedAlert() {
        self.displayFailureAlert(
            message: "회원가입에 실패했습니다.\n잠시후 다시 시도해주세요."
        )
    }
}
