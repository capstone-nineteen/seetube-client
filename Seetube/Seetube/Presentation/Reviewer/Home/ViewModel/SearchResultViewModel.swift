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
    private var searchKeyword: String?
    
    init(
        searchUseCase: SearchUseCase,
        searchKeyword: String?
    ) {
        self.searchUseCase = searchUseCase
        self.searchKeyword = searchKeyword
    }
    
    func transform(input: Input) -> Output {
        let searchResult = Driver
            .merge(
                input.viewWillAppear,
                input.searchButtonClicked
            )
            .withLatestFrom(
                Driver.merge(
                    input.searchBarText,
                    Driver.just(self.searchKeyword)
                )
            ) { _, text in
                text
            }
            .compactMap { $0 }
            .filter { $0.count > 0 }
            .flatMap { keyword in
                self.searchUseCase
                    .execute(searchKeyword: keyword)
                    .asDriver(onErrorJustReturn: VideoList())
            }
        let videos = searchResult
            .map { $0.videos }
            .map { $0.map { ReviewerVideoCardItemViewModel(with: $0) }}
        let selectedVideoId = input.itemSelected
            .asDriver()
            .withLatestFrom(
                searchResult
            ) { index, searchResult in
                searchResult.videos[index.row].videoId
            }
        let initialSearchKeyword = Driver
            .just(self.searchKeyword)
        
        return Output(videos: videos,
                      selectedVideoId: selectedVideoId,
                      initialSearchKeyword: initialSearchKeyword)
    }
}

extension SearchResultViewModel {
    struct Input {
        let viewWillAppear: Driver<Void>
        let searchButtonClicked: Driver<Void>
        let searchBarText: Driver<String?>
        let itemSelected: Driver<IndexPath>
    }
    
    struct Output {
        let videos: Driver<[ReviewerVideoCardItemViewModel]>
        let selectedVideoId: Driver<Int>
        let initialSearchKeyword: Driver<String?>
    }
}
