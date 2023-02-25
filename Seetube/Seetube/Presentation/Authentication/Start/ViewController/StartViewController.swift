//
//  StartViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/26.
//

import UIKit
import RxSwift
import RxCocoa

class StartViewController: UIViewController,
                           LoginPushable
{
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
        self.configureNavigationBar()
        self.configureReviewerButton()
        self.configureYoutuberButton()
    }
    
    private func configureNavigationBar() {
        self.rx.viewWillAppear
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.navigationController?.isNavigationBarHidden = true
            }
            .disposed(by: self.disposeBag)
        
        self.rx.viewWillDisappear
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.navigationController?.isNavigationBarHidden = false
            }
            .disposed(by: self.disposeBag)
    }
    
    private func configureReviewerButton() {
        self.reviewerButton.rx.tap
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.pushLogin(userType: .reviewer)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func configureYoutuberButton() {
        self.youtuberButton.rx.tap
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.pushLogin(userType: .youtuber)
            }
            .disposed(by: self.disposeBag)
    }
}
