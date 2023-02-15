//
//  VideoDetailViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit
import RxCocoa
import RxSwift

class ReviewerVideoDetailViewController: UIViewController {
    @IBOutlet weak var videoDetailView: ReviewerVideoDetailView!
    
    var viewModel: ReviewerVideoDetailViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
    }
}

// MARK: - Configuration

extension ReviewerVideoDetailViewController {
    private func configureUI() {
        self.configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.rx.viewWillAppear
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.navigationController?.isNavigationBarHidden = false
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - ViewModel Binding

extension ReviewerVideoDetailViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let viewWillAppear = self.viewWillAppearEvent()
        
        let input = ReviewerVideoDetailViewModel.Input(viewWillAppear: viewWillAppear)
        let output = viewModel.transform(input: input)
        
        self.bindVideo(output.video)
    }
    
    // MARK: Input Event Creation
    
    private func viewWillAppearEvent() -> Driver<Void> {
        return self.rx.viewWillAppear
            .asDriver()
            .map { _ in () }
    }
    
    // MARK: Output Binding
    
    private func bindVideo(_ video: Driver<VideoDetailViewModel>) {
        self.videoDetailView
            .bind(with: video)
            .disposed(by: self.disposeBag)
    }
}
