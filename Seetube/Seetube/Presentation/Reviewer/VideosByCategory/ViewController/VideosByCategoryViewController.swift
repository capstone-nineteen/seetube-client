//
//  CategoryViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit
import RxCocoa
import RxSwift

class VideosByCategoryViewController: UIViewController {
    @IBOutlet weak var categoryButtons: CategoryButtonScrollView!
    private var tableViewController: ReviewerVideoInfoTableViewController? {
        self.children.first as? ReviewerVideoInfoTableViewController
    }
    
    var viewModel: VideosByCategoryViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: bind UI로 변경
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // TODO: 셀 터치 시 화면 전환
}

// MARK: - ViewModel Binding

extension VideosByCategoryViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let categoryChanged = self.categoryChanged()
        
        let input = VideosByCategoryViewModel.Input(categoryChanged: categoryChanged)
        let output = viewModel.transform(input: input)
        
        self.bindVideos(output.filteredVideos)
    }
    
    // MARK: Input Event Creation
    
    private func categoryChanged() -> Driver<Int> {
        // TODO: 버튼 바인드
        return self.categoryButtons.rx.selectedIndex
            .asDriver()
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
}
