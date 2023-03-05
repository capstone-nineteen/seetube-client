//
//  YoutuberHomeViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/03.
//

import Foundation
import RxSwift
import RxCocoa

class YoutuberHomeViewModel: ViewModelType {
    private let fetchYoutuberHomeUseCase: FetchYoutuberHomeUseCase
    
    init(fetchYoutuberHomeUseCase: FetchYoutuberHomeUseCase) {
        self.fetchYoutuberHomeUseCase = fetchYoutuberHomeUseCase
    }
    
    func transform(input: Input) -> Output {
        let youtuberHome = input.viewWillAppear
            .flatMap { [weak self] _ -> Driver<YoutuberHome?> in
                // 더미데이터
                let videoInfo = VideoInfo(targetNumberOfReviewers: 10)
                let home = YoutuberHome(userName: "이름",
                                        finishedReviews: [videoInfo],
                                        reviewsInProgress: [videoInfo])
                return .just(home)
                
                guard let self = self else { return .just(nil) }
                return self.fetchYoutuberHomeUseCase
                    .execute()
                    .asDriver(onErrorJustReturn: nil)
            }
            .compactMap { $0 }
        
        let name = youtuberHome.map { "안녕하세요, \($0.userName)님" }
        
        let finishedReviews = youtuberHome
            .map { $0.finishedReviews }
        
        let reviewsInProgress = youtuberHome
            .map { $0.reviewsInProgress }
        
        let finishedReviewsViewModel = finishedReviews
            .map { $0.map { YoutuberFinishedVideoCardItemViewModel(with: $0) }}
        
        let reviewsInProgressViewModel = reviewsInProgress
            .map { $0.map { YoutuberInProgressVideoCardItemViewModel(with: $0) }}
        
        let selectedFinishedReviewId = input.selectedFinishedReviewItem
            .withLatestFrom(finishedReviews) { $1[$0.row].videoId }
        
        
        let selectedInProgressReviewId = input.selectedReviewInProgressItem
            .withLatestFrom(reviewsInProgress) { $1[$0.row].videoId }
        
        return Output(name: name,
                      finishedReviews: finishedReviewsViewModel,
                      reviewsInProgress: reviewsInProgressViewModel,
                      selectedFinishedReviewId: selectedFinishedReviewId,
                      selectedInProgressReviewId: selectedInProgressReviewId)
    }
}

extension YoutuberHomeViewModel {
    struct Input {
        let viewWillAppear: Driver<Bool>
        let selectedFinishedReviewItem: Driver<IndexPath>
        let selectedReviewInProgressItem: Driver<IndexPath>
    }
    
    struct Output {
        let name: Driver<String>
        let finishedReviews: Driver<[YoutuberFinishedVideoCardItemViewModel]>
        let reviewsInProgress: Driver<[YoutuberInProgressVideoCardItemViewModel]>
        let selectedFinishedReviewId: Driver<Int>
        let selectedInProgressReviewId: Driver<Int>
    }
}
