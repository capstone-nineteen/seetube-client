//
//  SearchResultViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/14.
//

import Foundation
import RxCocoa
import RxSwift

class SearchResultViewModel: ViewModelType {
    private let searchUseCase: SearchUseCase
    
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
        let selectedVideoId = input.itemSelected
            .withLatestFrom(searchResult) { index, searchResult in
                searchResult.videos[index.row].videoId
            }
            .asDriver()
        
        return Output(videos: videos,
                      selectedVideoId: selectedVideoId)
    }
}

extension SearchResultViewModel {
    struct Input {
        let viewDidLoad: Driver<Void>
        let searchButtonClicked: Driver<Void>
        let searchBarText: Driver<String?>
        let itemSelected: Driver<IndexPath>
    }
    
    struct Output {
        let videos: Driver<[ReviewerVideoCardItemViewModel]>
        let selectedVideoId: Driver<String>
    }
}
