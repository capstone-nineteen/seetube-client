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
                input.searchBarText
            ) { _, text in
                text
            }
            .compactMap { $0 }
            .filter { $0.count > 0 }
            .flatMap { [weak self] keyword -> Driver<VideoList?> in
                guard let self = self else { return .just(nil) }
                return self.searchUseCase
                    .execute(searchKeyword: keyword)
                    .map { $0 as VideoList? }
                    .asDriver(onErrorJustReturn: nil)
            }
            .compactMap { $0 }
        
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
        
        let initialSearchKeyword = self.searchKeyword
        
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
        let initialSearchKeyword: String?
    }
}
