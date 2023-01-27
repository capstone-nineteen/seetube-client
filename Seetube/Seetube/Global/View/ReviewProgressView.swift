//
//  ReviewProgressView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit

@IBDesignable
class ReviewProgressView: UIView, NibLoadable {
    @IBOutlet weak var progressView: UIProgressView!
    
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
    
    func updateProgress(_ progress: Float) {
        self.progressView.progress = progress
    }
}
