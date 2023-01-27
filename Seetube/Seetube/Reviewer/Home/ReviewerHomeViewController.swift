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
        self.collectionView.register(ReviewerHomeCollectionViewCell.self,
                                     forCellWithReuseIdentifier: ReviewerHomeCollectionViewCell.cellReuseIdentifier)
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
        5
    }
}

extension ReviewerHomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewerHomeCollectionViewCell.cellReuseIdentifier, for: indexPath) as? ReviewerHomeCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReviewerHomeSectionHeader.reuseIdentifier, for: indexPath) as? ReviewerHomeSectionHeader else { return UICollectionReusableView() }
        header.configure(title: "카테고리 \(indexPath.section)",
                         delegate: self)
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        5
    }
}

extension ReviewerHomeViewController: SeeAllButtonDelegate {
    func seeAllButtonTouched(_ sender: UIButton) {
        // 카테고리 뷰로 전환
    }
}
