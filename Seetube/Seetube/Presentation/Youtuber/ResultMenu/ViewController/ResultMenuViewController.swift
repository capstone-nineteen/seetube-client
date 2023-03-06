//
//  ResultMenuViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/12.
//

import UIKit
import RxCocoa
import RxSwift

class ResultMenuViewController: UIViewController,
                                ConcentrationResultPushable
{
    @IBOutlet weak var concentrationButton: ResultMenuButton!
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
}

// MARK: - Configuration

extension ResultMenuViewController {
    private func configureUI() {
        self.configureConcentrationButton()
    }
    
    private func configureConcentrationButton() {
        self.concentrationButton.rx.tap
            .asDriver()
            .drive(with: self) { obj, _ in
                // TODO: videoId 주입
                obj.pushConcentrationResult(videoId: 0)
            }
            .disposed(by: self.disposeBag)
    }
}
