//
//  VideoDetailView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit

@IBDesignable
class VideoDetailView: UIView, NibLoadable {
    @IBOutlet weak var thumbnailButton: VideoThumbnailButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var youtuberNameLabel: UILabel!
    @IBOutlet weak var rewardPriceStackView: UIStackView!
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
}
