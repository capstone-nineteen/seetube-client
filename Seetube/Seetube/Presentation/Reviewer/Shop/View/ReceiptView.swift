//
//  ReceiptView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/19.
//

import UIKit
import RxSwift
import RxCocoa

protocol WithdrawButtonDelegate: AnyObject {
    func withdrawButtonTouched(_ sender: BottomButton)
}

class ReceiptView: UIView, NibLoadable {
    @IBOutlet fileprivate weak var totalCoinLabel: AdaptiveFontSizeLabel!
    @IBOutlet fileprivate weak var withdrawlCoinTextField: NotPastableUnderLineTextField!
    @IBOutlet fileprivate weak var balanceCoinLabel: AdaptiveFontSizeLabel!
    
    private var disposeBag = DisposeBag()
    private weak var buttonDelegate: WithdrawButtonDelegate?
    private weak var textFieldDelegate: UITextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadFromNib(owner: self)
    }
    
    func configureButtonDelegate(_ delegate: WithdrawButtonDelegate) {
        self.buttonDelegate = delegate
    }
    
    func configureTextFieldDelegate(_ delegate: UITextFieldDelegate) {
        self.withdrawlCoinTextField.delegate = delegate
    }
    
    @IBAction func withDrawButtonTouched(_ sender: BottomButton) {
        self.buttonDelegate?.withdrawButtonTouched(sender)
    }
}

// MARK: - Reactive Extension

extension Reactive where Base: ReceiptView {
    var withdrawalText: ControlProperty<String?> {
        let source = base.withdrawlCoinTextField.rx.text
        let binder = Binder(base) { obj, text in
            base.withdrawlCoinTextField.text = text
            base.withdrawlCoinTextField.sendActions(for: .valueChanged)
        }
        
        return ControlProperty(values: source,
                               valueSink: binder)
    }
    
    var totalText: Binder<String?> {
        return base.totalCoinLabel.rx.text
    }
    
    var remainingText: Binder<String?> {
        return base.balanceCoinLabel.rx.text
    }
}
