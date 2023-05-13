//
//  SceneStealerResultViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/11.
//

import Foundation
import RxCocoa
import RxSwift

class SceneStealerResultViewModel: ViewModelType {
    private let videoId: Int
    private let fetchSceneStealerResultUseCase: FetchSceneStealerResultUseCase
    
    init(
        videoId: Int,
        fetchSceneStealerResultUseCase: FetchSceneStealerResultUseCase
    ) {
        self.videoId = videoId
        self.fetchSceneStealerResultUseCase = fetchSceneStealerResultUseCase
    }
    
    func transform(input: Input) -> Output {
        let result = input.viewWillAppear
            .flatMap { [weak self] _ -> Driver<SceneStealerResult?> in
                guard let self = self else { return .just(nil) }
                return self.fetchSceneStealerResultUseCase
                    .execute(videoId: self.videoId)
                    .map { $0 as SceneStealerResult? }
                    .asDriver(onErrorJustReturn: nil)
            }
            .compactMap { $0 }
        
        let imageUrl = input.itemSelected
            .withLatestFrom(result) { $1.scenes[$0.row] }
            .map { $0.imageURL }
        
        let scenes = result
            .map { $0.scenes }
            .map { $0.map { SceneItemViewModel(with: $0) } }
        
        return Output(imageUrl: imageUrl,
                      scenes: scenes)
    }
}

extension SceneStealerResultViewModel {
    struct Input {
        let viewWillAppear: Driver<Bool>
        let itemSelected: Driver<IndexPath>
    }
    
    struct Output {
        let imageUrl: Driver<String>
        let scenes: Driver<[SceneItemViewModel]>
    }
}
