//
//  SearchResultViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/14.
//

import Foundation
import RxCocoa

class SearchResultViewModel: ViewModelType {
    private let searchUseCase :SearchUseCase
    
    init(searchUseCase: SearchUseCase) {
        self.searchUseCase = searchUseCase
    }
    
    func transform(input: Input) -> Output {
        let searchResult = Driver
            .merge(input.viewDidLoad, input.searchButtonClicked)
            .withLatestFrom(input.searchBarText) { _, text in
                text
            }
            .compactMap { $0 }
            .flatMap { keyword in
                self.searchUseCase
                    .execute(searchKeyword: keyword)
                    .asDriver(onErrorJustReturn: VideoList())
            }
        let videos = searchResult
            .map {
                $0.videos.map { video in
                    ReviewerVideoCardItemViewModel(with: video)
                }
            }
        
        return Output(videos: videos)
    }
}

extension SearchResultViewModel {
    struct Input {
        let viewDidLoad: Driver<Void>
        let searchButtonClicked: Driver<Void>
        let searchBarText: Driver<String?>
    }
    
    struct Output {
        let videos: Driver<[ReviewerVideoCardItemViewModel]>
    }
}
