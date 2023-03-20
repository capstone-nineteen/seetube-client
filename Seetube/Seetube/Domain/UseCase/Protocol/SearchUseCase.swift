//
//  SearchUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/14.
//

import Foundation
import RxSwift

protocol SearchUseCase {
    func execute(searchKeyword: String) -> Single<VideoList>
}
