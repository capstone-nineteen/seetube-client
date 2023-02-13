//
//  ReviewerHomeViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/10.
//

import Foundation
import RxCocoa

class ReviewerHomeViewModel: ViewModelType {
    private let fetchReviewerHomeUseCase: FetchReviewerHomeUseCase
    
    init(fetchReviewerHomeUseCase: FetchReviewerHomeUseCase) {
        self.fetchReviewerHomeUseCase = fetchReviewerHomeUseCase
    }
    
    func transform(input: Input) -> Output {
        let home = input.viewWillAppear
            .flatMap { _ in
                self.fetchReviewerHomeUseCase.execute()
                    .asDriver(onErrorJustReturn: ReviewerHome())
            }
        let name = home
            .map { "안녕하세요, \($0.name)님" }
        let coin = home
            .map { $0.coin.toFormattedString() }
        let sections = home
            .map {
                $0.sections.map { section in
                    return ReviewerHomeSectionViewModel(with: section)
                }
            }
        let selectedSection = input.seeAllButtonTouched
            .withLatestFrom(home) { index, home in
                home.sections[index].category
            }
            .asDriver()
        let selectedVideoId = input.itemSelected
            .withLatestFrom(home) { index, home in
                home.sections[index.section][index.row].videoId
            }
            .asDriver()

        return Output(name: name,
                      coin: coin,
                      sections: sections,
                      selectedSection: selectedSection,
                      selectedVideoId: selectedVideoId)
    }
}

extension ReviewerHomeViewModel {
    struct Input {
        let viewWillAppear: Driver<Bool>
        let seeAllButtonTouched: Driver<Int>
        let itemSelected: Driver<IndexPath>
    }
    
    struct Output {
        let name: Driver<String>
        let coin: Driver<String>
        let sections: Driver<[ReviewerHomeSectionViewModel]>
        let selectedSection: Driver<Category>
        let selectedVideoId: Driver<String>
    }
}
