//
//  WithdrawalInformationViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/18.
//

import UIKit
import RxCocoa
import RxSwift

class WithdrawalInformationViewController: UIViewController,
                                           AlertDisplaying,
                                           KeyboardDismissible,
                                           TextFieldJoinable
{
    @IBOutlet weak var bankNameTextField: UnderLineTextField!
    @IBOutlet weak var accountHolderTextField: UnderLineTextField!
    @IBOutlet weak var accountNumberTextField: UnderLineTextField!
    @IBOutlet weak var registerButton: BottomButton!
    lazy var coverView = UIView()
    
    var viewModel: WithdrawalInformationViewModel?
    private var disposeBag = DisposeBag()
    private var confirmButtonTouched = PublishRelay<Void>()    // confirm alert의 OK 버튼과 연결된 Relay
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
    }
}

// MARK: - Configuration

extension WithdrawalInformationViewController {
    private func configureUI() {
        self.enableKeyboardDismissing()
        self.configureNavigationBar()
        self.configureTextFields()
    }
    
    private func configureTextFields() {
        let textFields = [self.bankNameTextField,
                          self.accountHolderTextField,
                          self.accountNumberTextField]
        self.joinTextFields(textFields)
            .disposed(by: self.disposeBag)
        
        self.accountNumberTextField.rx.text.orEmpty
            .asDriver()
            .map { $0.filter { $0.isNumber } }
            .drive(self.accountNumberTextField.rx.text)
            .disposed(by: self.disposeBag)
    }
    
    private func configureNavigationBar() {
        self.rx.viewWillAppear
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.navigationController?.isNavigationBarHidden = false
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - ViewModel Binding

extension WithdrawalInformationViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let bankName = self.bankNameText()
        let accountHolder = self.accountHolderText()
        let accountNumber = self.accountNumberText()
        let registerButtonTouched = self.registerButtonTouchedEvent()
        let confirmButtonTouched = self.confirmButtonTouchedEvent()
        
        let input = WithdrawalInformationViewModel.Input(
            bankName: bankName,
            accountHolder: accountHolder,
            accountNumber: accountNumber,
            registerButtonTouched: registerButtonTouched,
            confirmButtonTouched: confirmButtonTouched
        )
        let output = viewModel.transform(input: input)
        
        self.bindRegisterResult(output.registerResult)
        self.bindValidationError(output.validationError)
    }
    
    // MARK: Input Event Creation
    
    private func bankNameText() -> Driver<String> {
        return self.bankNameTextField.rx.text
            .orEmpty
            .asDriver()
    }
    
    private func accountHolderText() -> Driver<String> {
        return self.accountHolderTextField.rx.text
            .orEmpty
            .asDriver()
    }
    
    private func accountNumberText() -> Driver<String> {
        return self.accountNumberTextField.rx.text
            .orEmpty
            .asDriver()
    }
    
    private func registerButtonTouchedEvent() -> Driver<Void> {
        return self.registerButton.rx.tap.asDriver()
    }
    
    private func confirmButtonTouchedEvent() -> Driver<Void> {
        return self.confirmButtonTouched
            .map { $0 as Void? }
            .asDriver(onErrorJustReturn: nil)
            .compactMap { $0 }
    }
    
    // MARK: Output Binding
    
    private func bindRegisterResult(_ result: Driver<Bool>) {
        result
            .drive(with: self) { obj, success in
                if success {
                    self.displayRegisterSucceedAlert()
                } else {
                    self.displayRegisterFailedAlert()
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindValidationError(_ error: Driver<String?>) {
        error
            .drive(with: self) { obj, message in
                if let message = message {
                    self.displayValidationErrorAlert(message: message)
                } else {
                    self.displayConfirmAlert()
                }
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Alerts

extension WithdrawalInformationViewController {
    private func displayValidationErrorAlert(message: String) {
        self.displayFailureAlert(message: message)
    }
    
    private func displayConfirmAlert() {
        self.displayAlertWithAction(
            title: "환급 신청",
            message: "입력하신 정보가 올바른지 확인하십시오.\n해당 정보로 환급을 신청하시겠습니까?"
        ) { _ in
            self.confirmButtonTouched.accept(())
        }
    }
    
    private func displayRegisterFailedAlert() {
        self.displayFailureAlert(
            message: "환급 신청에 실패했습니다.\n잠시후 다시 시도해주세요."
        )
    }
    
    private func displayRegisterSucceedAlert() {
        self.displayAlertWithAction(
            title: "신청 완료",
            message: "환급 신청이 완료되었습니다."
        ) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
