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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let reviewerVideoDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ReviewerVideoDetailViewController") as? ReviewerVideoDetailViewController else { return }
        self.navigationController?.pushViewController(reviewerVideoDetailViewController, animated: true)
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
        guard let tabBarController = self.navigationController?.tabBarController,
              let categoryNavigationController = tabBarController.viewControllers?[1] as? UINavigationController,
              let categoryViewController = categoryNavigationController.topViewController as? CategoryViewController else { return }
        
        let _ = categoryViewController.view // CategoryViewController 강제 로드
        categoryViewController.selectCategory(category)
        tabBarController.selectedIndex = 1
    }
}
