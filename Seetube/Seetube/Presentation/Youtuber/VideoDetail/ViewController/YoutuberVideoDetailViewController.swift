//
//  YoutuberVideoDetailViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit
import RxCocoa
import RxSwift

class YoutuberVideoDetailViewController: UIViewController {
    @IBOutlet weak var videoDetailView: YoutuberVideoDetailView!
    
    var viewModel: YoutuberVideoDetailViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
    }
}

// MARK: - Configuration

extension YoutuberVideoDetailViewController {
    private func configureUI() {
        self.configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.rx.viewWillAppear
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.navigationController?.navigationBar.prefersLargeTitles = false
            }
            .disposed(by: self.disposeBag)
        
        self.rx.viewWillDisappear
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.navigationController?.navigationBar.prefersLargeTitles = true
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - ViewModel Binding

extension YoutuberVideoDetailViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let viewWillAppear = self.viewWillAppearEvent()
        
        let input = YoutuberVideoDetailViewModel.Input(viewWillAppear: viewWillAppear)
        let output = viewModel.transform(input: input)
        
        self.bindVideo(output.video)
    }
    
    // MARK: Input Event Creation
    
    private func viewWillAppearEvent() -> Driver<Bool> {
        return self.rx.viewWillAppear.asDriver()
    }
    
    // MARK: Output Binding
    
    private func bindVideo(_ video: Driver<VideoDetailViewModel>) {
        self.videoDetailView
            .bind(with: video)
            .disposed(by: self.disposeBag)
    }
}
