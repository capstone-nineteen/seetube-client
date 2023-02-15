//
//  YoutuberVideoDetailView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit

class YoutuberVideoDetailView: VideoDetailView {
    override func configureRewardPriceStackView() {
        self.rewardPriceStackView.isHidden = true
    }
}
