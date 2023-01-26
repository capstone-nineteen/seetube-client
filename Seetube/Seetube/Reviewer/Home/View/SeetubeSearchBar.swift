//
//  SeetubeSearchBar.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/26.
//

import UIKit

class SeetubeSearchBar: UISearchBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }
    
    private func configure() {
        self.searchTextField.backgroundColor = .white
        self.searchTextField.leftView?.tintColor = UIColor(named: "AccentColor")
        self.searchTextPositionAdjustment = UIOffset(horizontal: 3, vertical: 0)
        self.backgroundImage = UIImage()
        self.barTintColor = UIColor(named: "BackgroundColor")
        self.placeholder = "검색어를 입력하세요"
    }
}
