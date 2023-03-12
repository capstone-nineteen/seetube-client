//
//  SceneListLargeTableViewCell.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/13.
//

import UIKit
import Kingfisher

class SceneListLargeTableViewCell: UITableViewCell {
    static let cellReuseIdentifier = "SceneListLargeTableViewCell"
    static let cellHeight: CGFloat = 95
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var timeIntervalLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func prepareForReuse() {
        self.clear()
    }
    
    // TODO: bindImage 함수들 프로토콜화 리팩토링
    private func bindImage(url: String) {
        let processor = DownsamplingImageProcessor(size: self.thumbnailImageView.bounds.size)
        self.thumbnailImageView.kf.indicatorType = .activity
        self.thumbnailImageView.kf.setImage(
            with: URL(string: url),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.7)),
                .cacheOriginalImage
            ]
        )
    }
    
    func bind(_ viewModel: SceneLargeItemViewModel) {
        self.bindImage(url: viewModel.thumbnailUrl)
        self.timeIntervalLabel.text = viewModel.interval
        self.contentLabel.text = viewModel.description
    }
    
    func clear() {
        self.thumbnailImageView.kf.cancelDownloadTask()
        self.timeIntervalLabel.text = nil
        self.contentLabel.text = nil
    }
}
