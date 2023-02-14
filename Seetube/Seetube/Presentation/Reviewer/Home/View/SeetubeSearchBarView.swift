//
//  SeetubeSearchBarView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/26.
//

import UIKit
import RxSwift
import RxCocoa

@IBDesignable
class SeetubeSearchBarView: UIView {
    fileprivate lazy var searchBar: SeetubeSearchBar = {
        let searchBar = SeetubeSearchBar()
        return searchBar
    }()
    
    var searchKeyword: String? {
        self.searchBar.text
    }
    
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
    
    func dismissKeyboard() {
        self.searchBar.resignFirstResponder()
    }
    
    func bind(_ text: Driver<String?>) -> Disposable {
        return text
            .drive(self.searchBar.rx.text)
    }
}

extension Reactive where Base: SeetubeSearchBarView {
    var searchButtonClicked: ControlEvent<Void> {
        return base.searchBar.rx.searchButtonClicked
    }
    
    var searchKeyword: ControlProperty<String?> {
        return base.searchBar.rx.text
    }
}
