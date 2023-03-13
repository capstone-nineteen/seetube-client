//
//  ShortsCollectionViewCell.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/14.
//

import UIKit
import Kingfisher

class ShortsCollectionViewCell: UICollectionViewCell {
    static let cellReuseIdentifier = "ShortsCollectionViewCell"
    
    @IBOutlet private weak var thumbnailView: UIImageView!
    @IBOutlet private weak var timeIntervalLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var checkIconImageView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            self.checkIconImageView.isHidden = !isSelected
        }
    }
    
    private func bindImage(url: String) {
        let processor = DownsamplingImageProcessor(size: self.thumbnailView.bounds.size)
        self.thumbnailView.kf.indicatorType = .activity
        self.thumbnailView.kf.setImage(
            with: URL(string: url),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.7)),
                .cacheOriginalImage
            ]
        )
    }
    
    func bind(_ viewModel: ShortsItemViewModel) {
        self.bindImage(url: viewModel.thumbnailURL)
        self.timeIntervalLabel.text = viewModel.interval
        self.contentLabel.text = viewModel.description
    }
}
