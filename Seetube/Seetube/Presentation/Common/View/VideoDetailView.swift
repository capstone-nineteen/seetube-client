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
    @IBOutlet fileprivate weak var thumbnailButton: VideoThumbnailButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var youtuberNameLabel: UILabel!
    @IBOutlet private weak var rewardLabel: UILabel!
    @IBOutlet weak var rewardPriceStackView: UIStackView!
    @IBOutlet private weak var reviewProgressView: ReviewProgressView!
    @IBOutlet private weak var reviewPeriodLabel: UILabel!
    @IBOutlet private weak var videoDescriptionLabel: UILabel!
    @IBOutlet private weak var hashtagLabel: UILabel!
    @IBOutlet weak var bottomButton: BottomButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
        self.configureRewardPriceStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadFromNib(owner: self)
        self.configureRewardPriceStackView()
    }
    
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
                .drive(self.hashtagLabel.rx.text),
            viewModel
                .map { $0.shouldEnableBottomButton }
                .drive(self.rx.isBottomButtonEnabled),
            viewModel
                .map { $0.shouldEnableBottomButton }
                .drive(self.thumbnailButton.rx.isEnabled),
            viewModel
                .map { $0.buttonTitle }
                .drive(self.bottomButton.rx.text)
        )
    }
}

extension Reactive where Base: VideoDetailView {
    var isBottomButtonEnabled: Binder<Bool> {
        return Binder(base) { obj, isEnabled in
            base.bottomButton.isEnabled = isEnabled
        }
    }
    
    var bottomButtonTap: ControlEvent<Void> {
        return base.bottomButton.rx.tap
    }
    
    var thumbnailButtonTap: ControlEvent<Void> {
        return base.thumbnailButton.rx.tap
    }
}
