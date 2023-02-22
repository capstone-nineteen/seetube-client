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
    let url: String
    let videoId: Int
    let videoPlayerViewModel: VideoPlayerViewModel
    
    private var disposeBag: DisposeBag
    
    init(
        url: String,
        videoId: Int
    ) {
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
        
        let reviewSubmissionResult = input.reviewData
            .toArray()
            .asObservable()
            .flatMap { reviewDataCollection -> Observable<Bool> in
                // TODO: post review data
                print("DEBUG: \(reviewDataCollection)")
                // TODO: videoPlayerViewModel.videoRect 사용하여 좌표 normalize
                return .just(false)
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
        let reviewData: Observable<ReviewData>
    }
    
    struct Output {
        let playTime: Driver<Int>
        let videoRect: Driver<VideoRect>
        let didPlayToEndTime: Driver<Void>
        let reviewSubmissionResult: Driver<Bool>
    }
}
