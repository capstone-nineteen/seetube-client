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
                          WithdrawalInformationPushable,
                          AlertDisplaying,
                          KeyboardDismissible
{
    @IBOutlet weak var receiptView: ReceiptView!
    lazy var coverView = UIView()
    
    var viewModel: ShopViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
    }
}

// MARK: - Configuration

extension ShopViewController {
    private func configureUI() {
        self.configureNavigationBar()
        self.configureKeyboard()
        self.enableKeyboardDismissing()
    }
    
    private func configureNavigationBar() {
        self.rx.viewWillAppear
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.navigationController?.isNavigationBarHidden = true
            }
            .disposed(by: self.disposeBag)
    }
    
    private func configureKeyboard() {
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
            .map { _ -> Void? in () }
            .asDriver(onErrorJustReturn: nil)
            .compactMap { $0 }
            .drive(with: self) { obj, _ in
                obj.view.frame.origin.y = -150
            }
            .disposed(by: self.disposeBag)
        
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
            .map { _ -> Void? in () }
            .asDriver(onErrorJustReturn: nil)
            .compactMap { $0 }
            .drive(with: self) { obj, _ in
                obj.view.frame.origin.y = 0
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - ViewModel Binding

extension ShopViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let viewWillAppear = self.viewWillAppearEvent()
        let withdrawalAmountChanged = self.withdrawalAmountChangedEvent()
        let withdrawalButtonTouched = self.withdrawalButtonTouchedEvent()
        
        let input = ShopViewModel.Input(
            viewWillAppear: viewWillAppear,
            withdrawalAmountChanged: withdrawalAmountChanged,
            withdrawalButtonTouched: withdrawalButtonTouched
        )
        let output = viewModel.transform(input: input)
        
        self.bindTotal(output.total)
        self.bindWithdrawal(output.withdrawal)
        self.bindRemaining(output.remaining)
        self.bindAmountExceedError(output.amountExceedError)
        self.bindShouldMoveToWithdrawalInfo(output.shouldMoveToWithdrawalInfo)
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
    
    private func withdrawalButtonTouchedEvent() -> Driver<Void> {
        return self.receiptView.rx.withdrawalButtonTap.asDriver()
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
    
    private func bindShouldMoveToWithdrawalInfo(_ shouldMoveToWithdrawalInfo: Driver<Int>) {
        shouldMoveToWithdrawalInfo
            .drive(with: self) { obj, amount in
                obj.pushWithdrawalInfromation(withdrawlAmount: amount)
            }
            .disposed(by: self.disposeBag)
    }
}
