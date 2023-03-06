//
//  ConcentrationResultViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/06.
//

import Foundation
import RxCocoa
import RxSwift

class ConcentrationResultViewModel: ViewModelType {
    private let videoId: Int
    private let fetchConcentrationResultUseCase: FetchConcentrationResultUseCase
    
    init(
        videoId: Int,
        fetchConcentrationResultUseCase: FetchConcentrationResultUseCase
    ) {
        self.videoId = videoId
        self.fetchConcentrationResultUseCase = fetchConcentrationResultUseCase
    }
    
    func transform(input: Input) -> Output {
        let result = input.viewWillAppear
            .flatMap { [weak self] _ -> Driver<ConcentrationResult?> in
                guard let self = self else { return .just(nil) }
                return self.fetchConcentrationResultUseCase
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
            .debug()
            .withLatestFrom(result) { $1.scenes[$0.row] }
            .map { (start: $0.startTime, end: $0.endTime) }
        
        return Output(videoUrl: videoUrl,
                      scenes: scenes,
                      playingInterval: playingInterval)
    }
}

extension ConcentrationResultViewModel {
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
