//
//  ReviewerVideoDetailViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/15.
//

import Foundation
import RxCocoa
import RxSwift

class ReviewerVideoDetailViewModel: ViewModelType {
    private let fetchVideoInfoUseCase: FetchVideoDetailUseCase
    private let videoId: Int
    
    init(
        fetchVideoInfoUseCase: FetchVideoDetailUseCase,
        videoId: Int
    ) {
        self.fetchVideoInfoUseCase = fetchVideoInfoUseCase
        self.videoId = videoId
    }
    
    func transform(input: Input) -> Output {
        let video = input.viewWillAppear
            .flatMap { [weak self] _ -> Driver<VideoInfo?> in
                guard let self = self else { return .just(nil) }
                return self.fetchVideoInfoUseCase
                    .execute(id: self.videoId)
                    .map { $0 as VideoInfo? }
                    .asDriver(onErrorJustReturn: nil)
            }
            .compactMap { $0 }
        
        let videoViewModels = video
            .map {
                let buttonTitle = $0.didReviewed ? "리뷰 완료" : "리뷰 시작하기"
                let didReviewFinished = $0.currentNumberOfReviewers == $0.targetNumberOfReviewers
                return VideoDetailViewModel(with: $0,
                                            buttonTitle: buttonTitle,
                                            shouldEnableBottomButton: !didReviewFinished)
            }
        
        let videoInfo = input.startButtonTouched
            .withLatestFrom(
                video.map { (url: $0.videoPath, id: $0.videoId) }
            ) { $1 }
        
        return Output(video: videoViewModels,
                      shouldMoveToWatch: videoInfo)
    }
}

extension ReviewerVideoDetailViewModel {
    struct Input {
        let viewWillAppear: Driver<Void>
        let startButtonTouched: Driver<Void>
    }
    
    struct Output {
        let video: Driver<VideoDetailViewModel>
        let shouldMoveToWatch: Driver<(url: String, id: Int)>
    }
}
