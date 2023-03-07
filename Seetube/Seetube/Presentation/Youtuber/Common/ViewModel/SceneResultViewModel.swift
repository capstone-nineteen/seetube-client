//
//  SceneResultViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/08.
//

import Foundation
import RxCocoa
import RxSwift

class SceneResultViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: Driver<Bool>
        let itemSelected: Driver<IndexPath>
    }
    
    struct Output {
        let videoUrl: Driver<String>
        let scenes: Driver<[SceneItemViewModel]>
        let playingInterval: Driver<(start: Int, end: Int)>
    }
    
    func transform(input: Input) -> Output {
        return Output(videoUrl: .never(),
                      scenes: .never(),
                      playingInterval: .never())
    }
}
