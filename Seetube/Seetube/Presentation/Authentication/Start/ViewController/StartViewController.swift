//
//  StartViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/26.
//

import UIKit
import RxSwift
import RxCocoa

class StartViewController: UIViewController {
    @IBOutlet weak var reviewerButton: UserTypeButton!
    @IBOutlet weak var youtuberButton: UserTypeButton!
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
}

// MARK: - Configuration

extension StartViewController {
    private func configureUI() {
        self.configureReviewerButton()
        self.configureYoutuberButton()
    }
    
    private func configureReviewerButton() {
        self.reviewerButton.rx.tap
            .asDriver()
            .drive(onNext: {
                print("reviwerButtonTap")
            })
            .disposed(by: self.disposeBag)
    }
    
    private func configureYoutuberButton() {
        self.youtuberButton.rx.tap
            .asDriver()
            .drive(onNext: {
                print("youtuberButtonTap")
            })
            .disposed(by: self.disposeBag)
    }
}
