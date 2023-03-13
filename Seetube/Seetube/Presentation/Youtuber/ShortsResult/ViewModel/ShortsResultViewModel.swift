//
//  ShortsResultViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/13.
//

import Foundation
import RxCocoa
import RxSwift

class ShortsResultViewModel: ViewModelType {
    private let videoId: Int
    private let fetchShortsResultUseCase: FetchShortsResultUseCase
    
    init(
        videoId: Int,
        fetchShortsResultUseCase: FetchShortsResultUseCase
    ) {
        self.videoId = videoId
        self.fetchShortsResultUseCase = fetchShortsResultUseCase
    }
    
    func transform(input: Input) -> Output {
        let result = input.viewWillAppear
            .flatMap { [weak self] _ -> Driver<ShortsResult?> in
                // 더미 데이터
                let scene = ShortsScene(thumbnailURL: "https://avatars.githubusercontent.com/u/70833900?s=80&u=7b4aff238820c6e6d3968848b78e8d8bf1b1507e&v=4", videoURL: "", startTime: 0, endTime: 3, concentrationPercentage: 20, emotionType: .angry, emotionPerentage: 24)
                let temp = ShortsResult(scenes: [scene, scene, scene, scene, scene, scene, scene])
                return .just(temp)
                
                guard let self = self else { return .just(nil) }
                return self.fetchShortsResultUseCase
                    .execute(videoId: self.videoId)
                    .asDriver(onErrorJustReturn: nil)
            }
            .compactMap { $0 }
        
        let isSelectionMode = Driver
            .merge(
                input.selectedButtonTouched
                    .map { _ in true },
                input.saveButtonTouched
                    .map { _ in false }
            )
            .startWith(false)
        
        let shorts = Driver
            .combineLatest(
                result.map { $0.scenes },
                isSelectionMode
            ) { ($0, $1) }
            .map { (scenes, isSelectionMode) in
                scenes.map {
                    ShortsItemViewModel(with: $0,
                                        shouldDisplayCheckIcon: isSelectionMode)
                }
            }
        
        // TODO: 선택된 쇼츠들 다운로드
        let selectedShorts = Driver
            .combineLatest(
                input.itemSelected,
                isSelectionMode
            ) { (itemSelected: $0, isSelectionMode: $1) }
            .scan([], accumulator: { acc, element in
                element.isSelectionMode ? [] : acc + [element.itemSelected]
            })
        
        let shouldPlay = input.itemSelected
            .withLatestFrom(isSelectionMode) {
                (itemSelected: $0, isSelectionMode: $1)
            }
            .filter { !$0.1 }
            .scan(nil) { previous, element -> IndexPath? in
                let current = element.itemSelected
                return (previous == current) ? nil : current
            }
            .debug("should play output")
        
        return Output(shorts: shorts,
                      shouldPlay: shouldPlay,
                      saveResult: .just(false))
    }
}

extension ShortsResultViewModel {
    struct Input {
        let viewWillAppear: Driver<Bool>
        let itemSelected: Driver<IndexPath>
        let selectedButtonTouched: Driver<Void>
        let saveButtonTouched: Driver<Void>
    }
    
    struct Output {
        let shorts: Driver<[ShortsItemViewModel]>
        let shouldPlay: Driver<IndexPath?>
        let saveResult: Driver<Bool>
    }
}
