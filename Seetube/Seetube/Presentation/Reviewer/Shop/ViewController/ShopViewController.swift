//
//  ShopViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/16.
//

import UIKit
import RxCocoa
import RxSwift

class ShopViewController: UIViewController,
                          ViewControllerPushable,
                          AlertDisplaying
{
    @IBOutlet weak var receiptView: ReceiptView!
    
    var viewModel: ShopViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDelegate()
        self.configureKeyboard()
        self.bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Configuration

extension ShopViewController {
    private func configureDelegate() {
        self.receiptView.configureButtonDelegate(self)
    }
    
    private func configureKeyboard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - ViewModel Binding

extension ShopViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let viewWillAppear = self.viewWillAppearEvent()
        let withdrawalAmountChanged = self.withdrawalAmountChangedEvent()
        
        let input = ShopViewModel.Input(
            viewWillAppear: viewWillAppear,
            withdrawalAmountChanged: withdrawalAmountChanged
        )
        let output = viewModel.transform(input: input)
        
        self.bindTotal(output.total)
        self.bindWithdrawal(output.withdrawal)
        self.bindRemaining(output.remaining)
        self.bindAmountExceedError(output.amountExceedError)
    }
    
    // MARK: Input Event Creation
    
    private func viewWillAppearEvent() -> Driver<Bool> {
        return self.rx.viewWillAppear.asDriver()
    }
    
    private func withdrawalAmountChangedEvent() -> Driver<String> {
        return self.receiptView.rx.withdrawalText
            .orEmpty
            .asDriver()
    }
    
    // MARK: Output Binding
    
    private func bindTotal(_ total: Driver<String>) {
        total
            .drive(self.receiptView.rx.totalText)
            .disposed(by: self.disposeBag)
    }
    
    private func bindWithdrawal(_ withdrawal: Driver<String>) {
        withdrawal
            .drive(self.receiptView.rx.withdrawalText)
            .disposed(by: self.disposeBag)
    }
    
    private func bindRemaining(_ remaining: Driver<String>) {
        remaining
            .drive(self.receiptView.rx.remainingText)
            .disposed(by: self.disposeBag)
    }
    
    private func bindAmountExceedError(_ error: Driver<Void>) {
        error
            .drive(with: self) { obj, _ in
                obj.displayFailureAlert(
                    message: "보유 코인량을 초과할 수 없습니다."
                )
            }
            .disposed(by: self.disposeBag)
    }
}

extension ShopViewController {
    @objc private func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150
    }
    
    @objc private func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
}

extension ShopViewController: WithdrawButtonDelegate {
    func withdrawButtonTouched(_ sender: BottomButton) {
        self.push(viewControllerType: WithdrawalInformationViewController.self)
    }
}
