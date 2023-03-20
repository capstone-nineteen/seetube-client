//
//  YoutuberVideoDetailViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/05.
//

import Foundation
import RxCocoa
import RxSwift

class YoutuberVideoDetailViewModel: ViewModelType {
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
                VideoDetailViewModel(with: $0,
                                     buttonTitle: "결과 확인하기",
                                     shouldEnableBottomButton: false)
            }
        
        return Output(video: videoViewModels)
    }
}

extension YoutuberVideoDetailViewModel {
    struct Input {
        let viewWillAppear: Driver<Bool>
    }
    
    struct Output {
        let video: Driver<VideoDetailViewModel>
    }
}
