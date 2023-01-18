//
//  ReceiptView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/19.
//

import UIKit

protocol WithdrawButtonDelegate {
    func withdrawButtonTouched(_ sender: BottomButton)
}

class ReceiptView: UIView, NibLoadable {
    @IBOutlet weak var totalCoinLabel: AdaptiveFontSizeLabel!
    @IBOutlet weak var withdrawlCoinLabel: WithdrawlCoinTextField!
    @IBOutlet weak var balanceCoinLabel: AdaptiveFontSizeLabel!
    
    private var delegate: WithdrawButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadFromNib(owner: self)
    }
    
    func configureDelegate(_ delegate: WithdrawButtonDelegate) {
        self.delegate = delegate
    }
    
    @IBAction func withDrawButtonTouched(_ sender: BottomButton) {
        self.delegate?.withdrawButtonTouched(sender)
    }
}
