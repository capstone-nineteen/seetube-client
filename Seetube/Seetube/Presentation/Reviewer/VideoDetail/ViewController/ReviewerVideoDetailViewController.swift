//
//  VideoDetailViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit
import RxCocoa
import RxSwift

class ReviewerVideoDetailViewController: UIViewController,
                                         WatchPresentable
{
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
        let startButtonTouched = self.startButtonTouchedEvent()
        
        let input = ReviewerVideoDetailViewModel.Input(
            viewWillAppear: viewWillAppear,
            startButtonTouched: startButtonTouched
        )
        let output = viewModel.transform(input: input)
        
        self.bindVideo(output.video)
        self.bindShouldMoveToWatch(output.shouldMoveToWatch)
    }
    
    // MARK: Input Event Creation
    
    private func viewWillAppearEvent() -> Driver<Void> {
        return self.rx.viewWillAppear
            .asDriver()
            .map { _ in () }
    }
    
    private func startButtonTouchedEvent() -> Driver<Void> {
        return self.videoDetailView.rx.bottomButtonTap
            .asDriver()
    }
    
    // MARK: Output Binding
    
    private func bindVideo(_ video: Driver<VideoDetailViewModel>) {
        self.videoDetailView
            .bind(with: video)
            .disposed(by: self.disposeBag)
    }
    
    private func bindShouldMoveToWatch(_ shouldMoveToWatch: Driver<String>) {
        shouldMoveToWatch
            .drive(with: self) { obj, url in
                obj.presentWatch(with: url)
            }
            .disposed(by: self.disposeBag)
    }
}
