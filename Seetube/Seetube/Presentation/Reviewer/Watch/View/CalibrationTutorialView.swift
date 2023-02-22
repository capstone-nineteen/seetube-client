//
//  CalibrationTutorialView.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/19.
//

import UIKit
import RxSwift
import RxCocoa

class CalibrationTutorialView: UIView, NibLoadable {
    @IBOutlet fileprivate weak var startButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
        self.showLoader()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadFromNib(owner: self)
        self.showLoader()
    }
    
    private func showLoader() {
        activityIndicatorView.startAnimating()
        startButton.isHidden = true
        activityIndicatorView.isHidden = false
    }

    func hideLoader() {
        activityIndicatorView.stopAnimating()
        startButton.isHidden = false
        activityIndicatorView.isHidden = true
    }
}

// MARK: - Reactive Extension

extension Reactive where Base: CalibrationTutorialView {
    var startButtonTap: ControlEvent<Void> {
        return base.startButton.rx.tap
    }
}
