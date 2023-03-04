//
//  YoutuberHomeViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/19.
//

import UIKit
import RxCocoa
import RxSwift

class YoutuberHomeViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UnderlineSegmentedControl!
    @IBOutlet weak var finishedReviewsView: UIView!
    @IBOutlet weak var reviewsInProgressView: UIView!
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}

// MARK: - Configuration

extension YoutuberHomeViewController {
    private func configureUI() {
        self.configureSegmentedControl()
    }
    
    private func configureSegmentedControl() {
        self.segmentedControl.rx.selectedSegmentIndex
            .asDriver()
            .drive(with: self) { obj, index in
                switch index {
                case 0:
                    obj.finishedReviewsView.isHidden = false
                    obj.reviewsInProgressView.isHidden = true
                case 1:
                    obj.finishedReviewsView.isHidden = true
                    obj.reviewsInProgressView.isHidden = false
                default:
                    return
                }
            }
            .disposed(by: self.disposeBag)
    }
}
