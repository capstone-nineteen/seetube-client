//
//  WatchViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/19.
//

import Foundation
import RxSwift
import RxCocoa
import SeeSo

class WatchViewModel: ViewModelType {
    private let submitReviewUseCase: SubmitReviewUseCase
    
    private let url: String
    private let videoId: Int
    
    let videoPlayerViewModel: VideoPlayerViewModel
    private var disposeBag: DisposeBag
    
    init(
        submitReviewUseCase: SubmitReviewUseCase,
        url: String,
        videoId: Int
    ) {
        self.submitReviewUseCase = submitReviewUseCase
        // TODO: S3 권한 요청 후 Info.plist NSAppTransportSecurity 삭제
        self.url = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
        self.videoId = videoId
        self.videoPlayerViewModel = VideoPlayerViewModel(url: self.url)
        self.disposeBag = DisposeBag()
    }
    
    func transform(input: Input) -> Output {
        let shouldPlay = input.watchingState
            .asObservable()
            .filter { $0 == .calibrationFinished }
            .map { _ -> Void in () }
        
        shouldPlay
            .bind(to: self.videoPlayerViewModel.shouldPlay)
            .disposed(by: self.disposeBag)
        
        let playTime = self.videoPlayerViewModel.playTime
            .asDriverIgnoringError()
        
        let videoRect = self.videoPlayerViewModel.videoRect
            .asDriverIgnoringError()
        
        let didPlayToEndTime = self.videoPlayerViewModel.didPlayToEndTime
            .asDriverIgnoringError()
        
        let reviewSubmissionResult = input.rawReview
            .toArray()
            .asObservable()
            .flatMap { [weak self] rawReviews -> Observable<Bool> in
                guard let self = self else { return .just(false) }
                let reviews = Reviews(videoId: self.videoId,
                                      reviews: rawReviews.map { Review(rawReview: $0) })
                return self.submitReviewUseCase
                    .execute(reviews: reviews)
            }
            .asDriver(onErrorJustReturn: false)
        
        return Output(playTime: playTime,
                      videoRect: videoRect,
                      didPlayToEndTime: didPlayToEndTime,
                      reviewSubmissionResult: reviewSubmissionResult)
    }
}

extension WatchViewModel {
    struct Input {
        let watchingState: Driver<WatchingState>
        let rawReview: Observable<RawReview>
    }
    
    struct Output {
        let playTime: Driver<Int>
        let videoRect: Driver<VideoRect>
        let didPlayToEndTime: Driver<Void>
        let reviewSubmissionResult: Driver<Bool>
    }
}
