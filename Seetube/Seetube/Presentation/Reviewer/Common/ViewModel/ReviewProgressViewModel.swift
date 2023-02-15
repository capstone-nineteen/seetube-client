//
//  ReviewProgressViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/15.
//

import Foundation

class ReviewProgressViewModel {
    let targetNumberOfReviews: String
    let progressPercentage: Float
    let progressDescription: String
    
    init(current: Int, target: Int) {
        self.targetNumberOfReviews = "\(target)개"
        self.progressPercentage = Float(current) / Float(target)
        self.progressDescription = "👤 \(current)/\(target)명 참여"
    }
}
