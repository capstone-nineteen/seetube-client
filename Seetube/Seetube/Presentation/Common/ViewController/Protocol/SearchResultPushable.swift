//
//  SerachResultPushable.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/15.
//

import Foundation

protocol SearchResultPushable: ViewControllerPushable {
    func pushSearchResult(searchKeyword: String?)
}

extension SearchResultPushable {
    func pushSearchResult(searchKeyword: String?) {
        self.push(
            viewControllerType: SearchResultViewController.self
        ) { viewController in
            let repository = DefaultReviewerHomeRepository()
            let searchUseCase = DefaultSearchUseCase(repository: repository)
            let viewModel = SearchResultViewModel(searchUseCase: searchUseCase,
                                                  searchKeyword: searchKeyword)
            viewController.viewModel = viewModel
        }
    }
}
