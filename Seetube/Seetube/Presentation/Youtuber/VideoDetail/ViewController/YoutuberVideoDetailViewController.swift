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
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
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
