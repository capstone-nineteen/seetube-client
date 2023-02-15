//
//  VideoDetailView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit
import RxSwift
import RxCocoa

@IBDesignable
class VideoDetailView: UIView, NibLoadable {
    @IBOutlet weak var thumbnailButton: VideoThumbnailButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var youtuberNameLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var rewardPriceStackView: UIStackView!
    @IBOutlet weak var reviewProgressView: ReviewProgressView!
    @IBOutlet weak var reviewPeriodLabel: UILabel!
    @IBOutlet weak var videoDescriptionLabel: UILabel!
    @IBOutlet weak var hashtagLabel: UILabel!
    @IBOutlet weak var bottomButton: BottomButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
        self.configureBottomButtonName()
        self.configureRewardPriceStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadFromNib(owner: self)
        self.configureBottomButtonName()
        self.configureRewardPriceStackView()
    }
    
    func configureBottomButtonName() { }
    func configureRewardPriceStackView() { }
    
    func bind(with viewModel: Driver<VideoDetailViewModel>) -> Cancelable {
        return Disposables.create (
            viewModel
                .map { $0.thumbnailImageUrl }
                .drive(with: self) { obj, url in
                    obj.thumbnailButton.setThumbnailImage(url: url)
                },
            viewModel
                .map { $0.title }
                .drive(self.titleLabel.rx.text),
            viewModel
                .map { $0.youtuber }
                .drive(self.youtuberNameLabel.rx.text),
            viewModel
                .map { $0.reward }
                .drive(self.rewardLabel.rx.text),
            self.reviewProgressView
                .bind(with: viewModel.map { $0.progressViewModel }),
            viewModel
                .map { $0.reviewPeriod }
                .drive(self.reviewPeriodLabel.rx.text),
            viewModel
                .map { $0.videoDescription }
                .drive(self.videoDescriptionLabel.rx.text),
            viewModel
                .map { $0.hashtags }
                .drive(self.hashtagLabel.rx.text)
        )
    }
}
