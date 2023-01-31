//
//  VideoDetailThumbnailView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit

protocol VideoThumbnailButtonDelegate: AnyObject {
    func videoThumbnailButtonTouched(_ sender: VideoThumbnailButton)
}

class VideoThumbnailButton: UIButton, NibLoadable {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    private weak var delegate: VideoThumbnailButtonDelegate?
    
    override var isHighlighted: Bool {
        didSet {
            self.alpha = isHighlighted ? 0.7 : 1.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
        self.configureAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadFromNib(owner: self)
        self.configureAction()
    }
    
    private func configureAction() {
        self.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.videoThumbnailButtonTouched(self)
        }), for: .touchUpInside)
    }
}
