//
//  WatchViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/19.
//

import Foundation
import RxSwift
import RxCocoa

class WatchViewModel: ViewModelType {
    let url: String
    let videoPlayerViewModel: VideoPlayerViewModel
    private var disposeBag: DisposeBag
    
    init(url: String) {
        // TODO: S3 권한 요청 후 Info.plist NSAppTransportSecurity 삭제
        self.url = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
        self.videoPlayerViewModel = VideoPlayerViewModel(url: self.url)
        self.disposeBag = DisposeBag()
    }
    
    func transform(input: Input) -> Output {
        let shouldPlay = input.watchingState
            .asObservable()
            .filter { $0 == .calibrationFinished }
            .map { _ -> Void in () }
        
        shouldPlay
            .bind(to: self.videoPlayerViewModel.shouldPlay)
            .disposed(by: self.disposeBag)
        
        return Output()
    }
}

extension WatchViewModel {
    struct Input {
        let watchingState: Driver<WatchingState>
    }
    
    struct Output {
    }
}
