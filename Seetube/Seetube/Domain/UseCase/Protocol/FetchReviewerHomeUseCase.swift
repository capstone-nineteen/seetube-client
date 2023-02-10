//
//  FetchReviewerHomeUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/10.
//

import Foundation
import RxSwift

protocol FetchReviewerHomeUseCase {
    func execute() -> Observable<ReviewerHome>
}
