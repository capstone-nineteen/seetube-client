//
//  AdaptiveFontSizeLabel.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/17.
//

import UIKit

class AdaptiveFontSizeLabel: UILabel {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.font = self.font.withSize(self.bounds.height * 0.7)
    }
}
