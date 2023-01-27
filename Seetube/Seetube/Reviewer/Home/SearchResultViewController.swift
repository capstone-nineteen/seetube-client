//
//  SearchResultViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/26.
//

import UIKit

class SearchResultViewController: UIViewController {
    var searchKeyword: String?
    @IBOutlet weak var searchBarView: SeetubeSearchBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSearchBar()
        self.configureTapGesture()
    }
}

extension SearchResultViewController {
    private func configureSearchBar() {
        self.searchBarView.configureSearchBarDelegate(self)
        self.searchBarView.updateSearchBarText(with: self.searchKeyword)
    }
    
    private func configureTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tap)
    }
}

extension SearchResultViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.searchKeyword = searchBar.text
        // TODO: reload tableview
    }
}
