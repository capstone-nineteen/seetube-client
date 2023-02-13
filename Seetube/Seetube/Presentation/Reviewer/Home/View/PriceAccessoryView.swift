//
//  PriceAccessoryView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/26.
//

import UIKit
import RxCocoa
import RxSwift

class PriceAccessoryView: UIView, NibLoadable {
    @IBOutlet private weak var priceLabel: AdaptiveFontSizeLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadFromNib(owner: self)
    }
    
    func bind(with price: Driver<String>) -> Disposable {
        return price.drive(self.priceLabel.rx.text)
    }

    func bind(_ price: String) {
        self.priceLabel.text = price
    }
}
