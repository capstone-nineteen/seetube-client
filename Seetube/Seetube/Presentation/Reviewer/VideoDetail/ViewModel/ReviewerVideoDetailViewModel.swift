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
            .flatMap { _ -> Driver<VideoInfo> in
                self.fetchVideoInfoUseCase
                    .execute(id: self.videoId)
                    .asDriver(onErrorJustReturn: VideoInfo())
            }
            .map { VideoDetailViewModel(with: $0) }
        
        return Output(video: video)
    }
}

extension ReviewerVideoDetailViewModel {
    struct Input {
        let viewWillAppear: Driver<Void>
    }
    
    struct Output {
        let video: Driver<VideoDetailViewModel>
    }
}
