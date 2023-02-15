//
//  FetchVideosByCategoryUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/16.
//

import Foundation
import RxSwift

protocol FetchVideosByCategoryUseCase{
    func execute(category: Category) -> Observable<VideoList>
}
