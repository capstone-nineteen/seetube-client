//
//  EmotionResultViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/07.
//

import Foundation
import RxCocoa
import RxSwift

class EmotionResultViewModel: ViewModelType {
    private let videoId: Int
    private let fetchEmotionResultUseCase: FetchEmotionResultUseCase
    
    init(
        videoId: Int,
        fetchEmotionResultUseCase: FetchEmotionResultUseCase
    ) {
        self.videoId = videoId
        self.fetchEmotionResultUseCase = fetchEmotionResultUseCase
    }
    
    func transform(input: Input) -> Output {
        let result = input.viewWillAppear
            .flatMap { [weak self] _ -> Driver<EmotionResult?> in
                // 더미데이터
                let emotions: [Emotion] = [.angry, .happy, .surprise, .fear, .disgust]
                let scenes = (0..<5).map {
                    EmotionScene(thumbnailImageURL: "https://avatars.githubusercontent.com/u/70833900?s=80&u=7b4aff238820c6e6d3968848b78e8d8bf1b1507e&v=4",
                                                   startTime: 5*$0,
                                                   endTime: 5*$0+5,
                                                   totalNumberOfReviewers: 200,
                                 numberOfReviewersFelt: 162,
                                 emotionType: emotions[$0])
                }
                let temp = EmotionResult(originalVideoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                                               scenes: scenes)
                return .just(temp)
                
                guard let self = self else { return .just(nil) }
                return self.fetchEmotionResultUseCase
                    .execute(videoId: self.videoId)
                    .asDriver(onErrorJustReturn: nil)
            }
            .compactMap { $0 }
        
        let videoUrl = result
            .map { $0.originalVideoURL }
        
        let scenes = result
            .map { $0.scenes }
            .map { $0.map { SceneItemViewModel(with: $0) } }
        
        let playingInterval = input.itemSelected
            .withLatestFrom(result) { $1.scenes[$0.row] }
            .map { (start: $0.startTime, end: $0.endTime) }
        
        return Output(videoUrl: videoUrl,
                      scenes: scenes,
                      playingInterval: playingInterval)
    }
}

extension EmotionResultViewModel {
    struct Input {
        let viewWillAppear: Driver<Bool>
        let itemSelected: Driver<IndexPath>
    }
    
    struct Output {
        let videoUrl: Driver<String>
        let scenes: Driver<[SceneItemViewModel]>
        let playingInterval: Driver<(start: Int, end: Int)>
    }
}
