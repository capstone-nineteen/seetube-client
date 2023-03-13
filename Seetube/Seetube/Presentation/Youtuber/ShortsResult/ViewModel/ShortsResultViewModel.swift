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
                guard let self = self else { return .just(nil) }
                return self.fetchShortsResultUseCase
                    .execute(videoId: self.videoId)
                    .asDriver(onErrorJustReturn: nil)
            }
            .compactMap { $0 }
        
        let shorts = result
            .map { $0.scenes }
            .map { $0.map { ShortsItemViewModel(with: $0) } }
        
        let isSelectionMode = Driver
            .merge(
                input.selectedButtonTouched
                    .map { _ in true },
                input.saveButtonTouched
                    .map { _ in false }
            )
            .startWith(false)
        
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

class ShortsItemViewModel {
    let thumbnailURL: String
    let interval: String
    let description: String
    
    init(with scene: ShortsScene) {
        self.thumbnailURL = scene.thumbnailURL
        self.interval = "🕔 " + StringFormattingHelper.toTimeIntervalFormatString(startSecond: scene.startTime,
                                                                                  endSecond: scene.endTime)
        self.description = "집중도 \(scene.concentrationPercentage)%\n\(scene.emotionType.korDescription) \(scene.emotionPerentage)%"
    }
}
