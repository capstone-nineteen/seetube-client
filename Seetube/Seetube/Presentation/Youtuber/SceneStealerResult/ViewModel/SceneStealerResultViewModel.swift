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
                // 더미 데이터
                let scenes = (0..<5).map {
                    SceneStealerScene(imageURL: "https://avatars.githubusercontent.com/u/70833900?s=80&u=7b4aff238820c6e6d3968848b78e8d8bf1b1507e&v=4",
                                                   startTime: 5*$0,
                                                   endTime: 5*$0+5,
                                                   percentageOfConcentration: ($0+1)*10)
                }
                let temp = SceneStealerResult(scenes: scenes)
                return .just(temp)
                
                guard let self = self else { return .just(nil) }
                return self.fetchSceneStealerResultUseCase
                    .execute(videoId: self.videoId)
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
