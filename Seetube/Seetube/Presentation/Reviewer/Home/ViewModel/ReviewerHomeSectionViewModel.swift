//
//  ReviewerHomeSectionViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/10.
//

import Foundation
import RxCocoa

class ReviewerHomeSectionViewModel {
    let title: String
    let videos: [ReviewerHomeVideoItemViewModel]
    
    init(with section: ReviewerHomeSection) {
        if section.category == .all {
            self.title = "새로운 영상"
        } else {
            self.title = section.category.rawValue
        }
        self.videos = section.videos.map { ReviewerHomeVideoItemViewModel(with: $0) }
    }
}
