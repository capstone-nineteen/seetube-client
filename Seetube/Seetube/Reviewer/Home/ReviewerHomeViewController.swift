//
//  ReviewerHomeViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/28.
//

import UIKit

class ReviewerHomeViewController: KeyboardDismissibleViewController {
    @IBOutlet weak var searchBarView: SeetubeSearchBarView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension ReviewerHomeViewController {
    private func configureSearchBar() {
        self.searchBarView.configureSearchBarDelegate(self)
    }
}

extension ReviewerHomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchKeyword = searchBar.text {
            self.moveToSearchResult(searchKeyword: searchKeyword)
        }
    }
    
    func moveToSearchResult(searchKeyword: String?) {
        guard let searchResultViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchResultViewController") as? SearchResultViewController else { return }
        searchResultViewController.searchKeyword = searchKeyword
        self.navigationController?.pushViewController(searchResultViewController, animated: true)
    }
}
