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
    
    init(fetchVideosByCategoryUseCase: FetchVideosByCategoryUseCase) {
        self.fetchVideosByCategoryUseCase = fetchVideosByCategoryUseCase
    }
    
    func transform(input: Input) -> Output {
        let filteredVideos = input.categoryChanged
            .flatMap { [weak self] category -> Driver<VideoList> in
                // TODO: 다른 viewmodel도 weak 처리
                guard let self = self else { return Driver.just(VideoList()) }
                return self.fetchVideosByCategoryUseCase
                    .execute(category: category)
                    .asDriver(onErrorJustReturn: VideoList())
            }
            .map { $0.videos }
            .map { $0.map { ReviewerVideoCardItemViewModel(with: $0) }}
        // TODO: 전체를 받아온 다음 클라이언트에서 filter 해주는게 더 효율적이지 않나?
        return Output(filteredVideos: filteredVideos)
    }
}

extension VideosByCategoryViewModel {
    struct Input {
        let categoryChanged: Driver<Category>
    }
    
    struct Output {
        let filteredVideos: Driver<[ReviewerVideoCardItemViewModel]>
    }
}
