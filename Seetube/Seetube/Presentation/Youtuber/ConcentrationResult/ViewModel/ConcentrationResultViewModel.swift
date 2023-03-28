//
//  ConcentrationResultViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/06.
//

import Foundation
import RxCocoa
import RxSwift

class ConcentrationResultViewModel: SceneResultViewModel {
    private let videoId: Int
    private let fetchConcentrationResultUseCase: FetchConcentrationResultUseCase
    
    init(
        videoId: Int,
        fetchConcentrationResultUseCase: FetchConcentrationResultUseCase
    ) {
        self.videoId = videoId
        self.fetchConcentrationResultUseCase = fetchConcentrationResultUseCase
    }
    
    override func transform(input: Input) -> Output {
        let result = input.viewWillAppear
            .flatMap { [weak self] _ -> Driver<ConcentrationResult?> in
                guard let self = self else { return .just(nil) }
                return self.fetchConcentrationResultUseCase
                    .execute(videoId: self.videoId)
                    .map { $0 as ConcentrationResult? }
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
