//
//  SearchResultViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/26.
//

import UIKit
import RxCocoa
import RxSwift

class SearchResultViewController: UIViewController, KeyboardDismissible {
    @IBOutlet weak var searchBarView: SeetubeSearchBarView!
    var coverView = UIView()
    
    var viewModel: SearchResultViewModel?
    private var disposeBag = DisposeBag()
    var searchKeyword: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
}

// MARK: - Configuration

extension SearchResultViewController {
    private func configureUI() {
        self.enableKeyboardDismissing()
        self.configureSearchBar()
    }
    
    private func configureSearchBar() {
        self.searchBarView.rx.searchButtonClicked
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.searchBarView.dismissKeyboard()
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - ViewModel Binding

extension SearchResultViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let viewDidLoad = self.viewDidLoadEvent()
        let searchButtonClicked = self.searchButtonClickedEvent()
        let searchBarText = self.searchBarTextProperty()
        
        let input = SearchResultViewModel.Input(viewDidLoad: viewDidLoad,
                                                searchButtonClicked: searchButtonClicked,
                                                searchBarText: searchBarText)
        let output = viewModel.transform(input: input)
        
        // 테이블 뷰컨트롤러에 전달
        guard let tableViewController = self.children.first
                as? ReviewerVideoInfoTableViewController else { return }
        output.videos
            .drive(tableViewController.rx.shouldReload)
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Input Events Creation
    
    private func viewDidLoadEvent() -> Driver<Void> {
        return self.rx.viewDidLoad.asDriver()
    }
    
    private func searchButtonClickedEvent() -> Driver<Void> {
        return self.searchBarView.rx.searchButtonClicked.asDriver()
    }
    
    private func searchBarTextProperty() -> Driver<String?> {
        return self.searchBarView.rx.searchKeyword.asDriver()
    }
}
