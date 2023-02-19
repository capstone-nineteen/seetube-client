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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadFromNib(owner: self)
    }
}

// MARK: - Reactive Extension

extension Reactive where Base: CalibrationTutorialView {
    var startButtonTap: ControlEvent<Void> {
        return base.startButton.rx.tap
    }
}
