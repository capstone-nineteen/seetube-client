//
//  WatchViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/18.
//

import Foundation
import RxSwift
import RxCocoa

class VideoPlayerViewModel: ViewModelType {
    let url: String
    let shouldPlay: PublishRelay<Void>
    
    init(url: String) {
        self.url = url
        self.shouldPlay = PublishRelay()
    }
    
    func transform(input: Input) -> Output {
        let shouldPlay = self.shouldPlay
            .asDriverIgnoringError()
        
        return Output(shouldPlay: shouldPlay)
    }
}

extension VideoPlayerViewModel {
    struct Input {
    }
    
    struct Output {
        let shouldPlay: Driver<Void>
    }
}
