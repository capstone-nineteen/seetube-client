//
//  ReviewProgressView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit
import RxSwift
import RxCocoa

@IBDesignable
class ReviewProgressView: UIView, NibLoadable {
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet weak var targetNumberLabel: UILabel!
    @IBOutlet weak var progressDescriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadFromNib(owner: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.progressView.subviews.forEach { subview in
            subview.layer.masksToBounds = true
            subview.layer.cornerRadius = self.progressView.bounds.height / 2.0
        }
    }
    
    func bind(with viewModel: Driver<ReviewProgressViewModel>) -> Cancelable {
        return Disposables.create(
            viewModel
                .map { $0.progressPercentage }
                .drive(self.progressView.rx.progress),
            viewModel
                .map { $0.targetNumberOfReviews }
                .drive(self.targetNumberLabel.rx.text),
            viewModel
                .map { $0.progressDescription }
                .drive(self.progressDescriptionLabel.rx.text)
        )
    }
}
