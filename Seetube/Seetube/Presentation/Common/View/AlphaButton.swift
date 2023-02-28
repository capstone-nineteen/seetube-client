//
//  AlphaButton.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import UIKit

class AlphaButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.backgroundColor = self.tintColor?.withAlphaComponent(1.0)
            } else {
                self.backgroundColor = .systemGray2.withAlphaComponent(0.5)
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.7)
            } else {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(1.0)
            }
        }
    }
}
