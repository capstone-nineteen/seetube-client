//
//  SeetubeSearchBarView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/26.
//

import UIKit

@IBDesignable
class SeetubeSearchBarView: UIView {
    private lazy var searchBar: SeetubeSearchBar = {
        let searchBar = SeetubeSearchBar()
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureLayout()
        self.configureStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureLayout()
        self.configureStyle()
    }

    private func configureLayout() {
        let uiSearchBarHorizontalPadding: CGFloat = 8
        let uiSearchBarVerticalPadding: CGFloat = 4
        
        self.addSubview(self.searchBar)
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.searchBar.widthAnchor.constraint(equalTo: self.widthAnchor, constant: uiSearchBarHorizontalPadding * 2),
            self.searchBar.heightAnchor.constraint(equalTo: self.heightAnchor, constant: uiSearchBarVerticalPadding * 4),
            self.searchBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.searchBar.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func configureStyle() {
        self.backgroundColor = .clear
    }
    
    func configureSearchBarDelegate(_ delegate: UISearchBarDelegate) {
        self.searchBar.delegate = delegate
    }
    
    func updateSearchBarText(with text: String?) {
        self.searchBar.text = text
    }
}
