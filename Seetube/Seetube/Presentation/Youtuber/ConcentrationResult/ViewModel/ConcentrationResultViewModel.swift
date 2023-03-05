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
            .map { $0.map { ConcentrationSceneItemViewModel(with: $0) } }
        
        return Output(videoUrl: videoUrl,
                      scenes: scenes)
    }
}

extension ConcentrationResultViewModel {
    struct Input {
        let viewWillAppear: Driver<Bool>
    }
    
    struct Output {
        let videoUrl: Driver<String>
        let scenes: Driver<[ConcentrationSceneItemViewModel]>
    }
}
