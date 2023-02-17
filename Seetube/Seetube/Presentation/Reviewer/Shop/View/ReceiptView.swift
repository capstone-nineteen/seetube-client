//
//  ReceiptView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/19.
//

import UIKit
import RxSwift
import RxCocoa

class ReceiptView: UIView, NibLoadable {
    @IBOutlet fileprivate weak var totalCoinLabel: AdaptiveFontSizeLabel!
    @IBOutlet fileprivate weak var withdrawlCoinTextField: NotPastableUnderLineTextField!
    @IBOutlet fileprivate weak var balanceCoinLabel: AdaptiveFontSizeLabel!
    @IBOutlet weak var withdrawalButton: BottomButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadFromNib(owner: self)
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
    
    var withdrawalButtonTap: ControlEvent<Void> {
        return base.withdrawalButton.rx.tap
    }
}
