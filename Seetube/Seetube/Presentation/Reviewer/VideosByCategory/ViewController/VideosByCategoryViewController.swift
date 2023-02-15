//
//  CategoryViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit
import RxCocoa
import RxSwift

class VideosByCategoryViewController: UIViewController,
                                      ReviewerVideoDetailPushable
{
    @IBOutlet weak var categoryButtons: CategoryButtonScrollView!
    private var tableViewController: ReviewerVideoInfoTableViewController? {
        self.children.first as? ReviewerVideoInfoTableViewController
    }
    
    var viewModel: VideosByCategoryViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
    }
    
    // TODO: 셀 터치 시 화면 전환
}

// MARK: - Configuration

extension VideosByCategoryViewController {
    private func configureUI() {
        self.configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.rx.viewWillAppear
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.navigationController?.isNavigationBarHidden = true
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - ViewModel Binding

extension VideosByCategoryViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let categoryChanged = self.categoryChanged()
        let itemSelected = self.itemSelectedEvent()
        
        let input = VideosByCategoryViewModel.Input(
            categoryChanged: categoryChanged,
            itemSelected: itemSelected
        )
        let output = viewModel.transform(input: input)
        
        self.bindVideos(output.filteredVideos)
        self.bindSelectedVideoId(output.selectedVideoId)
    }
    
    // MARK: Input Event Creation
    
    private func categoryChanged() -> Driver<Int> {
        // TODO: 버튼 바인드
        return self.categoryButtons.rx.selectedIndex
            .asDriver()
    }
    
    private func itemSelectedEvent() -> Driver<IndexPath> {
        guard let tableViewController = self.tableViewController else {
            return Driver<IndexPath>.just(IndexPath())
        }
        
        return tableViewController.rx.itemSelected.asDriver()
    }
    
    // MARK: Output Binding
    
    private func bindVideos(_ videos: Driver<[ReviewerVideoCardItemViewModel]>) {
        // 테이블 뷰컨트롤러에 전달
        guard let tableViewController = self.children.first
                as? ReviewerVideoInfoTableViewController else { return }
        
        videos
            .drive(tableViewController.rx.viewModels)
            .disposed(by: self.disposeBag)
    }
    
    private func bindSelectedVideoId(_ selectedVideoId: Driver<Int>) {
        selectedVideoId
            .drive(with: self) { obj, id in
                obj.pushVideoDetail(videoId: id)
            }
            .disposed(by: self.disposeBag)
    }
}
