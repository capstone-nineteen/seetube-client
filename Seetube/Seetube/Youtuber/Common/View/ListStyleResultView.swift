//
//  ListStyleResultView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/14.
//

import UIKit

class ListStyleResultView: UIView, NibLoadable {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadFromNib(owner: self)
    }

}
