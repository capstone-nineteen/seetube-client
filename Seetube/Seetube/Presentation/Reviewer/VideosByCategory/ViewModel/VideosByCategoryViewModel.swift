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
    var selectedCategory = BehaviorRelay<Category>(value: .all)
    
    init(fetchVideosByCategoryUseCase: FetchVideosByCategoryUseCase) {
        self.fetchVideosByCategoryUseCase = fetchVideosByCategoryUseCase
    }
    
    func transform(input: Input) -> Output {
        let videos = input.categoryChanged
            .map { Category.allCases[$0] }
            .flatMap { [weak self] category -> Driver<VideoList?> in
                // TODO: 다른 viewmodel도 weak 처리
                // FIXME: 뒤늦게 온 이전 카테고리 응답을 필터링해야 함
                guard let self = self else { return .just(nil) }
                return self.fetchVideosByCategoryUseCase
                    .execute(category: category)
                    .asDriver(onErrorJustReturn: nil)
            }
            .map { $0?.videos ?? [] }
        
        let videoViewModels = videos
            .map { $0.map { ReviewerVideoCardItemViewModel(with: $0) }}
        
        let selectedIndex = self.selectedCategory
            .asDriver()
            .map { Category.allCases.firstIndex(of: $0) }
            .compactMap { $0 }
        
        let selectedVideoId = input.itemSelected
            .asDriver()
            .withLatestFrom(
                videos
            ) { index, searchResult in
                searchResult[index.row].videoId
            }
        
        // TODO: 전체를 받아온 다음 클라이언트에서 filter 해주는게 더 효율적이지 않나?
        return Output(filteredVideos: videoViewModels,
                      selectedIndex: selectedIndex,
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
        let selectedIndex: Driver<Int>
        let selectedVideoId: Driver<Int>
    }
}
