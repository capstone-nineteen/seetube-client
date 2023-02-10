//
//  ReviewerHomeViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/10.
//

import Foundation
import RxCocoa

class ReviewerHomeViewModel: ViewModelType {
    private let fetchReviewerHomeUseCase: FetchReviewerHomeUseCase
    
    init(fetchReviewerHomeUseCase: FetchReviewerHomeUseCase) {
        self.fetchReviewerHomeUseCase = fetchReviewerHomeUseCase
    }
    
    func transform(input: Input) -> Output {
        // dummy로 테스트
        let dummyVideo = VideoInfo(title: "제목",
                                   youtuberName: "유튜버",
                                   rewardAmount: 3000,
                                   currentNumberOfReviewers: 43,
                                   targetNumberOfReviewers: 80,
                                   reviewStartDate: Date.distantPast,
                                   reviewEndDate: Date.distantFuture,
                                   videoDescription: "설명설명")
        let dummySection = ReviewerHomeSection(title: "새로운 영상",
                                               videos: [dummyVideo, dummyVideo, dummyVideo])
        let home = input.viewWillAppear
            .flatMap { _ in
                self.fetchReviewerHomeUseCase.execute()
                    .asDriver(onErrorJustReturn: ReviewerHome(name: "아무개",
                                                              coin: 13294,
                                                              sections: [dummySection, dummySection])
                    )
            }
        
        let name = home.map { "안녕하세요, \($0.name)님" }
        let coin = home.map { $0.coin.toFormattedString() }
        let sections = home.map { home in
            home.sections.map { ReviewerHomeSectionViewModel(with: $0) }
        }
        
        return Output(name: name,
                      coin: coin,
                      sections: sections)
    }
}

extension ReviewerHomeViewModel {
    struct Input {
        let viewWillAppear: Driver<Bool>
    }
    
    struct Output {
        let name: Driver<String>
        let coin: Driver<String>
        let sections: Driver<[ReviewerHomeSectionViewModel]>
    }
}
