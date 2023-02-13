//
//  ReviewerHomeViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/28.
//

import UIKit
import RxSwift
import RxViewController
import RxCocoa

class ReviewerHomeViewController: UIViewController, KeyboardDismissible, ViewControllerPushable {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var coinAccessoryView: PriceAccessoryView!
    @IBOutlet weak var searchBarView: SeetubeSearchBarView!
    @IBOutlet var sectionViews: [ReviewerHomeSectionView]!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewTop: NSLayoutConstraint!
    var coverView = UIView()
    
    var viewModel: ReviewerHomeViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enableKeyboardDismissing()
        self.configureSearchBar()
        self.bindViewModel()
        self.bindUIEvents()
    }
}

// MARK: - Configuration

extension ReviewerHomeViewController {
    private func configureSearchBar() {
        self.searchBarView.configureSearchBarDelegate(self)
    }
}

// MARK: - ViewModel Binding

extension ReviewerHomeViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let viewWillAppear = self.viewWillAppearEvent()
        let seeAllButtonTouched = self.seeAllButtonTouchedEvent()
        let itemSelected = self.itemSelectedEvent()

        let input = ReviewerHomeViewModel.Input(viewWillAppear: viewWillAppear,
                                                seeAllButtonTouched: seeAllButtonTouched,
                                                itemSelected: itemSelected)
        let output = viewModel.transform(input: input)
        
        self.bindName(output.name)
        self.bindCoin(output.coin)
        self.bindSections(output.sections)
        self.bindSelectedSection(output.selectedSection)
        self.bindSelectedVideoId(output.selectedVideoId)
    }
    
    // MARK: Input Creation
    
    private func viewWillAppearEvent() -> Driver<Bool> {
        return self.rx.viewWillAppear.asDriver()
    }
    
    private func seeAllButtonTouchedEvent() -> Driver<Int> {
        return Driver.merge(
            self.sectionViews
                .enumerated()
                .map { index, sectionView in
                    sectionView.rx.seeAllButtonTouched
                        .asDriver()
                        .map { index }
                }
        )
    }
    
    private func itemSelectedEvent() -> Driver<IndexPath> {
        return Driver.merge(
            self.sectionViews
                .enumerated()
                .map { index, sectionView in
                    sectionView.rx.collectionViewItemSelected
                        .asDriver()
                        .map { IndexPath(row: $0.row, section: index) }
                }
        )
    }
    
    // MARK: Output Binding
    
    private func bindName(_ name: Driver<String>) {
        name
            .drive(self.nameLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
    
    private func bindCoin(_ coin: Driver<String>) {
        self.coinAccessoryView
            .bind(with: coin)
            .disposed(by: self.disposeBag)
    }
    
    private func bindSections(_ sections: Driver<[ReviewerHomeSectionViewModel]>) {
        self.sectionViews
            .enumerated()
            .forEach { [weak self] index, sectionView in
                guard let self = self else { return }
                sectionView
                    .bind(with: sections.map { $0[index] })
                    .disposed(by: self.disposeBag)
            }
    }
    
    private func bindSelectedSection(_ selectedSection: Driver<Category>) {
        selectedSection
            .drive(with: self) { owner, selectedSection in
                self.moveToCategoryTab(category: selectedSection)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindSelectedVideoId(_ selectedVideoId: Driver<String>) {
        selectedVideoId
            .drive(with: self) { owner, selectedVideoId in
                self.moveToVideoDetail(videoId: selectedVideoId)
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - UI Events Binding

extension ReviewerHomeViewController {
    private func bindUIEvents() {
        self.bindScrollView()
        self.bindViewWillAppear()
        self.bindViewWillDisappear()
    }
    
    private func bindScrollView() {
        self.scrollView.rx.didScroll
            .asDriver()
            .drive(with: self, onNext: { (owner, _) in
                let yOffset = owner.scrollView.contentOffset.y
                // TODO: Constants Enum으로 관리
                let maxScrollViewTop: CGFloat = 70
                let minScrollViewTop: CGFloat = 15
                let disappearRate: CGFloat = 0.05
                
                if yOffset < 0 {
                    owner.scrollViewTop.constant = min(maxScrollViewTop, owner.scrollViewTop.constant - yOffset)
                } else {
                    owner.scrollViewTop.constant = max(minScrollViewTop, owner.scrollViewTop.constant - yOffset * disappearRate)
                }
                owner.scrollView.layoutIfNeeded()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func bindViewWillAppear() {
        self.rx.viewWillAppear
            .asDriver()
            .drive(with: self, onNext: { owner, _ in
                owner.navigationController?.isNavigationBarHidden = true
            })
            .disposed(by: self.disposeBag)
    }
    
    private func bindViewWillDisappear() {
        self.rx.viewWillDisappear
            .asDriver()
            .drive(with: self, onNext: { owner, _ in
                owner.navigationController?.isNavigationBarHidden = false
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Seacrh Bar Delegate

extension ReviewerHomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchKeyword = searchBar.text {
            self.moveToSearchResult(searchKeyword: searchKeyword)
        }
    }
    
    func moveToSearchResult(searchKeyword: String?) {
        self.push(viewControllerType: SearchResultViewController.self) { viewController in
            viewController.searchKeyword = searchKeyword
        }
    }
}

// MARK: - Scene Transition

extension ReviewerHomeViewController {
    func moveToVideoDetail(videoId: String) {
        self.push(viewControllerType: ReviewerVideoDetailViewController.self) { viewController in
            // TODO: pass video id
        }
    }
    
    func moveToCategoryTab(category: Category) {
        guard let tabBarController = self.navigationController?.tabBarController,
              let categoryNavigationController = tabBarController.viewControllers?[1] as? UINavigationController,
              let categoryViewController = categoryNavigationController.topViewController as? VideosByCategoryViewController else { return }
        
        let _ = categoryViewController.view // CategoryViewController 강제 로드
        categoryViewController.selectCategory(category)
        tabBarController.selectedIndex = 1
    }
}
