//
//  SearchResultViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/26.
//

import UIKit

class SearchResultViewController: UIViewController, KeyboardDismissible {
    @IBOutlet weak var searchBarView: SeetubeSearchBarView!
    var coverView = UIView()
    
    var searchKeyword: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enableKeyboardDismissing()
        self.configureSearchBar()
    }
}

extension SearchResultViewController {
    private func configureSearchBar() {
        self.searchBarView.configureSearchBarDelegate(self)
        self.searchBarView.updateSearchBarText(with: self.searchKeyword)
    }
}

extension SearchResultViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.searchKeyword = searchBar.text
        // TODO: reload tableview
    }
}
