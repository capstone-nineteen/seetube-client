//
//  PriceAccessoryView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/26.
//

import UIKit

class PriceAccessoryView: UIView, NibLoadable {
    @IBOutlet weak var priceLabel: AdaptiveFontSizeLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadFromNib(owner: self)
    }
}
