//
//  VideoInfoCardView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/19.
//

import UIKit
import Kingfisher

@IBDesignable
class VideoInfoCardView: UIView, NibLoadable {
    @IBOutlet private weak var videoTitleLabel: AdaptiveFontSizeLabel!
    @IBOutlet private weak var youtuberNameTitle: AdaptiveFontSizeLabel!
    @IBOutlet private weak var dateLabel: AdaptiveFontSizeLabel!
    @IBOutlet private weak var personnelLabel: AdaptiveFontSizeLabel!
    @IBOutlet private weak var accesoryView: UIView!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadFromNib(owner: self)
    }
    
    func configureAccessoryView(_ view: UIView) {
        self.accesoryView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.accesoryView.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.accesoryView.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: self.accesoryView.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: self.accesoryView.trailingAnchor)
        ])
    }
    
    func bind(
        videoTitle: String,
        youtuberName: String,
        date: String,
        personnel: String,
        thumbnailUrl: String? = nil
    ) {
        self.videoTitleLabel.text = videoTitle
        self.youtuberNameTitle.text = youtuberName
        self.dateLabel.text = date
        self.personnelLabel.text = personnel
        
        if let thumbnailUrl = thumbnailUrl {
            let processor = DownsamplingImageProcessor(size: self.thumbnailImageView.bounds.size)
            self.thumbnailImageView.kf.indicatorType = .activity
            self.thumbnailImageView.kf.setImage(
                with: URL(string: thumbnailUrl),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.7)),
                    .cacheOriginalImage
                ]
            )
        } else {
            self.thumbnailImageView.kf.cancelDownloadTask()
        }
    }
}
