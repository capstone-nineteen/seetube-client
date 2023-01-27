//
//  ReviewerHomeSectionHeader.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/28.
//

import UIKit

protocol SeeAllButtonDelegate: AnyObject {
    func seeAllButtonTouched(_ sender: UIButton)
}

class ReviewerHomeSectionHeader: UICollectionReusableView {
    static let reuseIdentifier = "ReviewerHomeSectionHeader"

    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    private weak var delegate: SeeAllButtonDelegate?
    
    @IBAction func seeAllButtonTouched(_ sender: UIButton) {
        self.delegate?.seeAllButtonTouched(sender)
    }
    
    func configure(title: String, delegate: SeeAllButtonDelegate) {
        self.sectionTitleLabel.text = title
        self.delegate = delegate
    }
}
