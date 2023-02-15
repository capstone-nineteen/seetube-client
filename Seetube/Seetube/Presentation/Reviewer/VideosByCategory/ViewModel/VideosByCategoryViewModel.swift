//
//  VideosByCategoryViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/16.
//

import Foundation
import RxCocoa
import RxSwift

class VideosByCategoryViewModel: ViewModelType {
    private let fetchVideosByCategoryUseCase: FetchVideosByCategoryUseCase
    var selectedIndex = BehaviorRelay<Int>(value: 0)
    
    init(fetchVideosByCategoryUseCase: FetchVideosByCategoryUseCase) {
        self.fetchVideosByCategoryUseCase = fetchVideosByCategoryUseCase
    }
    
    func transform(input: Input) -> Output {
        let videos = input.categoryChanged
            .map { Category.allCases[$0] }
            .flatMap { [weak self] category -> Driver<VideoList?> in
                // TODO: 다른 viewmodel도 weak 처리
                guard let self = self else { return .just(nil) }
                return self.fetchVideosByCategoryUseCase
                    .execute(category: category)
                    .asDriver(onErrorJustReturn: nil)
                // TODO: 응답 오기 전까지는 로더/다 지워놨다가 왔을 때만 보여주게 해야 함, 안그러면 다른 이전 카테고리 영상들이 그대로 남아있음
            }
            .map { $0?.videos ?? [] }
        let videoViewModels = videos
            .map { $0.map { ReviewerVideoCardItemViewModel(with: $0) }}
        let selectedVideoId = input.itemSelected
            .asDriver()
            .withLatestFrom(
                videos
            ) { index, searchResult in
                searchResult[index.row].videoId
            }
        // TODO: 전체를 받아온 다음 클라이언트에서 filter 해주는게 더 효율적이지 않나?
        return Output(filteredVideos: videoViewModels,
        selectedVideoId: selectedVideoId)
    }
}

extension VideosByCategoryViewModel {
    struct Input {
        let categoryChanged: Driver<Int>
        let itemSelected: Driver<IndexPath>
    }
    
    struct Output {
        let filteredVideos: Driver<[ReviewerVideoCardItemViewModel]>
        let selectedVideoId: Driver<Int>
    }
}
