//
//  AdaptiveFontSizeLabel.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/17.
//

import UIKit

@IBDesignable
class AdaptiveFontSizeLabel: UILabel {
    override func layoutSubviews() {
        super.layoutSubviews()
        let lines = self.numberOfLines == 0 ? 1 : self.numberOfLines
        self.font = self.font.withSize(self.bounds.height * 0.7 / CGFloat(lines))
    }
}
