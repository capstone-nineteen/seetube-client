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
    private let checkAbusingUseCase: CheckAbusingUseCase
    
    private let url: String
    private let videoId: Int
    
    let videoPlayerViewModel: VideoPlayerViewModel
    private var disposeBag: DisposeBag
    
    init(
        submitReviewUseCase: SubmitReviewUseCase,
        checkAbusingUseCase: CheckAbusingUseCase,
        url: String,
        videoId: Int
    ) {
        self.submitReviewUseCase = submitReviewUseCase
        self.checkAbusingUseCase = checkAbusingUseCase
        self.url = url
        self.videoId = videoId
        self.videoPlayerViewModel = VideoPlayerViewModel(url: self.url)
        self.disposeBag = DisposeBag()
    }
    
    func transform(input: Input) -> Output {
        let playTime = self.videoPlayerViewModel.playTime
            .asDriverIgnoringError()
        
        let videoRect = self.videoPlayerViewModel.videoRect
            .asDriverIgnoringError()
        
        let didPlayToEndTime = self.videoPlayerViewModel.didPlayToEndTime
            .asDriverIgnoringError()
        
        let review = input.rawReview
            .map { Review(rawReview: $0) }
        
        let reviewSubmissionResult = review
            .toArray()
            .asObservable()
            .flatMap { [weak self] reviews -> Observable<Bool> in
                guard let self = self else { return .error(OptionalError.nilSelf) }
                
                let reviews = Reviews(videoId: self.videoId,
                                      reviews: reviews)
                return self.submitReviewUseCase
                    .execute(reviews: reviews)
                    .andThen(.just(true))
            }
            .asDriver(onErrorJustReturn: false)
        
        let videoDuration = VideoHelper.shared.getVideoDuration(videoURL: self.url) ?? INTPTR_MAX
        let isAbusingDetected = review
            .map { [weak self] review -> Bool in
                guard let self = self else { return false }
                return self.checkAbusingUseCase
                    .execute(review: review)
            }
            .scan(0) { $1 ? $0+1 : $0 }
            .map { Double($0) / Double(videoDuration) > 0.1 }
            .distinctUntilChanged()
            .filter { $0 }
            .mapToVoid()
            .asDriverIgnoringError()
        
        // VideoPlayerViewModel Binding
        
        let shouldPlay = input.watchingState
            .asObservable()
            .filter { $0 == .calibrationFinished }
            .map { _ -> Void in () }
    
        let shouldStop = isAbusingDetected
            .asObservable()
        
        self.bindToVideoPlayerViewModel(shouldPlay: shouldPlay,
                                        shouldStop: shouldStop)
        
        return Output(playTime: playTime,
                      videoRect: videoRect,
                      didPlayToEndTime: didPlayToEndTime,
                      isAbusingDetected: isAbusingDetected,
                      reviewSubmissionResult: reviewSubmissionResult)
    }
    
    private func bindToVideoPlayerViewModel(shouldPlay: Observable<Void>, shouldStop: Observable<Void>) {
        shouldPlay
            .bind(to: self.videoPlayerViewModel.shouldPlay)
            .disposed(by: self.disposeBag)
        
        shouldStop
            .bind(to: self.videoPlayerViewModel.shouldStop)
            .disposed(by: self.disposeBag)
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
        let isAbusingDetected: Driver<Void>
        let reviewSubmissionResult: Driver<Bool>
    }
}
