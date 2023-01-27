//
//  YoutuberVideoDetailView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit

class YoutuberVideoDetailView: VideoDetailView {
    override func configureBottomButtonName() {
        self.bottomButton.name = "결과 확인"
    }
    
    override func configureRewardPriceStackView() {
        self.rewardPriceStackView.isHidden = true
    }
}
