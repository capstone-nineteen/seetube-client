//
//  ReviewerVideoDetailView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit

class ReviewerVideoDetailView: VideoDetailView {
    override func configureBottomButtonName() {
        self.bottomButton.name = "리뷰 시작하기"
    }
}
