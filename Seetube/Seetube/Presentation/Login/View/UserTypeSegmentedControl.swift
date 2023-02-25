//
//  UserTypeSegmentedControl.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/25.
//

import UIKit

class UserTypeSegmentedControl: UISegmentedControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }
    
    private func configureUI() {
        let backgroundImage = UIImage()
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)

        self.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 14)
        ], for: .normal)
        self.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: Colors.seetubePink ?? UIColor.systemPink,
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ], for: .selected)
    }
}
