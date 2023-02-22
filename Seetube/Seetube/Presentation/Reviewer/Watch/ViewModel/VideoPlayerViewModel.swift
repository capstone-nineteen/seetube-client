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
    let playTime: PublishRelay<Int>
    let didPlayToEndTime: PublishRelay<Void>
    let videoRect: PublishRelay<VideoRect>
    
    private var disposeBag: DisposeBag
    
    init(url: String) {
        self.url = url
        self.shouldPlay = PublishRelay()
        self.playTime = PublishRelay()
        self.didPlayToEndTime = PublishRelay()
        self.videoRect = PublishRelay()
        self.disposeBag = DisposeBag()
    }
    
    func transform(input: Input) -> Output {
        input.playTime
            .asObservable()
            .bind(to: self.playTime)
            .disposed(by: self.disposeBag)
        
        input.didPlayToEndTime
            .asObservable()
            .bind(to: self.didPlayToEndTime)
            .disposed(by: self.disposeBag)
        
        input.videoRect
            .asObservable()
            .bind(to: self.videoRect)
            .disposed(by: self.disposeBag)
        
        let shouldPlay = self.shouldPlay
            .asDriverIgnoringError()
        
        return Output(shouldPlay: shouldPlay)
    }
}

extension VideoPlayerViewModel {
    struct Input {
        let playTime: Driver<Int>
        let didPlayToEndTime: Driver<Void>
        let videoRect: Driver<VideoRect>
    }
    
    struct Output {
        let shouldPlay: Driver<Void>
    }
}
