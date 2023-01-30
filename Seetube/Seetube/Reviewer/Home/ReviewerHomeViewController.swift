//
//  ReviewerHomeViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/28.
//

import UIKit

class ReviewerHomeViewController: KeyboardDismissibleViewController {
    @IBOutlet weak var searchBarView: SeetubeSearchBarView!
    @IBOutlet var sectionViews: [ReviewerHomeSectionView]!
    
    private var categories: [Category] = [.all, .beauty, .entertainment, .game]
    private var numberOfVideos: [Category: Int] = [.all:6, .beauty:3, .entertainment:7, .game:10]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSearchBar()
        self.configureCollectionView()
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
    
    private func configureCollectionView() {
        self.sectionViews.enumerated().forEach { (index, sectionView) in
            sectionView.configureDelegate(self)
            sectionView.configureCategory(self.categories[index])
        }
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

extension ReviewerHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let reviewerHomeCollectionView = collectionView as? ReviewerHomeCollectionView,
              let numberOfVideos = numberOfVideos[reviewerHomeCollectionView.category] else { return 0 }
        print(numberOfVideos)
        return numberOfVideos
    }
}

extension ReviewerHomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewerHomeCollectionViewCell.cellReuseIdentifier, for: indexPath) as? ReviewerHomeCollectionViewCell else { return UICollectionViewCell() }
        // TODO: configure
        return cell
    }
}

extension ReviewerHomeViewController: SeeAllButtonDelegate {
    func seeAllButtonTouched(category: Category) {
        // TODO: 카테고리 탭으로 전환
    }
}
