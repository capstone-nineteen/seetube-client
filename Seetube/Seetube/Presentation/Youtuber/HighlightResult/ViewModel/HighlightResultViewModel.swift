//
//  HighlightResultViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/12.
//

import Foundation
import RxCocoa
import RxSwift

class HighlightResultViewModel: ViewModelType {
    private let videoId: Int
    private let fetchHighlightResultUseCase: FetchHighlightResultUseCase
    
    init(
        videoId: Int,
        fetchHighlightResultUseCase: FetchHighlightResultUseCase
    ) {
        self.videoId = videoId
        self.fetchHighlightResultUseCase = fetchHighlightResultUseCase
    }
    
    func transform(input: Input) -> Output {
        let result = input.viewWillAppear
            .flatMap { [weak self] _ -> Driver<HighlightResult?> in
                // 더미 데이터
                let scenes = (0..<5).map {
                    HighlightScene(thumbnailImageURL: "https://avatars.githubusercontent.com/u/70833900?s=80&u=7b4aff238820c6e6d3968848b78e8d8bf1b1507e&v=4", startTimeInOriginalVideo: 12+$0*5, endTimeInOriginalVideo: 12+($0+1)*5, startTimeInHighlight: $0*5, endTimeInHighlight: ($0+1)*5, totalNumberOfReviewers: 140, numberOfReviewersConcentrated: 78, numberOfReviewersFelt: 100, emotionType: .angry)
                }
                let temp = HighlightResult(highlightVideoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                                               scenes: scenes)
                return .just(temp)
                
                guard let self = self else { return .just(nil) }
                return self.fetchHighlightResultUseCase
                    .execute(videoId: self.videoId)
                    .asDriver(onErrorJustReturn: nil)
            }
            .compactMap { $0 }
        
        let videoUrl = result
            .map { $0.highlightVideoURL }
        
        let scenes = result
            .map { $0.scenes }
            .map { $0.map { SceneLargeItemViewModel(with: $0) } }
        
        let playingInterval = input.itemSelected
            .withLatestFrom(result) { $1.scenes[$0.row] }
            .map { (start: $0.startTimeInHighlight, end: $0.endTimeInHighlight) }
        
        return Output(videoUrl: videoUrl,
                      scenes: scenes,
                      playingInterval: playingInterval)
    }
}

extension HighlightResultViewModel {
    struct Input {
        let viewWillAppear: Driver<Bool>
        let itemSelected: Driver<IndexPath>
    }
    
    struct Output {
        let videoUrl: Driver<String>
        let scenes: Driver<[SceneLargeItemViewModel]>
        let playingInterval: Driver<(start: Int, end: Int)>
    }
}
