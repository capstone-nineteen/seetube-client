//
//  EmotionResultViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/07.
//

import Foundation
import RxCocoa
import RxSwift

class EmotionResultViewModel: SceneResultViewModel {
    private let videoId: Int
    private let fetchEmotionResultUseCase: FetchEmotionResultUseCase
    
    init(
        videoId: Int,
        fetchEmotionResultUseCase: FetchEmotionResultUseCase
    ) {
        self.videoId = videoId
        self.fetchEmotionResultUseCase = fetchEmotionResultUseCase
    }
    
    override func transform(input: Input) -> Output {
        let result = input.viewWillAppear
            .flatMap { [weak self] _ -> Driver<EmotionResult?> in
                guard let self = self else { return .just(nil) }
                return self.fetchEmotionResultUseCase
                    .execute(videoId: self.videoId)
                    .map { $0 as EmotionResult? }
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
