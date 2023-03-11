//
//  ListStyleImageResultView.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/11.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

@IBDesignable
class ListStyleImageResultView: ListStyleResultView {
    fileprivate lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureImageView()
    }
    
    override func configureGuidanceLabel() {
        self.guidanceLabel.text = "원하는 씬스틸러를 선택하여 확인해보세요!"
    }
    
    private func configureImageView() {
        self.videoView.addSubview(self.imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.videoView.topAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.videoView.bottomAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.videoView.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.videoView.trailingAnchor)
        ])
    }
}

// MARK: - Reactive Extension

extension Reactive where Base: ListStyleImageResultView {
    var selectedThumbnailUrl: Binder<String?> {
        Binder(base) { obj, url in
            guard let url = url else {
                obj.imageView.kf.cancelDownloadTask()
                obj.guidanceLabel.isHidden = false
                return
            }
            
            obj.guidanceLabel.isHidden = true
            let processor = DownsamplingImageProcessor(size: obj.imageView.bounds.size)
            obj.imageView.kf.indicatorType = .activity
            obj.imageView.kf.setImage(
                with: URL(string: url),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.7)),
                    .cacheOriginalImage
                ]
            )
        }
    }
}
