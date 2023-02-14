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
    private var tableViewController: ReviewerVideoInfoTableViewController? {
        self.children.first as? ReviewerVideoInfoTableViewController
    }
    var coverView = UIView()
    
    var viewModel: SearchResultViewModel?
    private var disposeBag = DisposeBag()
    var searchKeyword: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
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
        let itemSelected = self.itemSelectedEvent()
        
        let input = SearchResultViewModel.Input(viewDidLoad: viewDidLoad,
                                                searchButtonClicked: searchButtonClicked,
                                                searchBarText: searchBarText,
                                                itemSelected: itemSelected)
        let output = viewModel.transform(input: input)
        
        self.bindVideos(output.videos)
        self.bindSelectedVideoId(output.selectedVideoId)
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
    
    private func itemSelectedEvent() -> Driver<IndexPath> {
        guard let tableViewController = self.tableViewController else {
            return Driver<IndexPath>.just(IndexPath())
        }
        
        return tableViewController.rx.itemSelected.asDriver()
    }
    
    // MARK: - Output Binding
    
    private func bindVideos(_ videos: Driver<[ReviewerVideoCardItemViewModel]>) {
        // 테이블 뷰컨트롤러에 전달
        guard let tableViewController = self.children.first
                as? ReviewerVideoInfoTableViewController else { return }
        
        videos
            .drive(tableViewController.rx.viewModels)
            .disposed(by: self.disposeBag)
    }
    
    private func bindSelectedVideoId(_ selectedVideoId: Driver<String>) {
        selectedVideoId
            .drive(with: self) { obj, id in
                obj.moveToVideoDetail(with: id)
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Scene Trasition

extension SearchResultViewController: ViewControllerPushable {
    private func moveToVideoDetail(with id: String) {
        self.push(viewControllerType: ReviewerVideoDetailViewController.self) { viewController in
            // TODO: id 주입
        }
    }
}
