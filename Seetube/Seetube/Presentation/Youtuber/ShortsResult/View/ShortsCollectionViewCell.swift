//
//  ShortsCollectionViewCell.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/14.
//

import UIKit

class ShortsCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var timeIntervalLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var checkIconImageView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            self.checkIconImageView.isHidden = !isSelected
        }
    }
}
