//
//  WatchViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/18.
//

import Foundation

class VideoPlayerViewModel: ViewModelType {
    let url: String
    
    init(url: String) {
        // TODO: S3 권한 요청 후 Info.plist NSAppTransportSecurity 삭제
        self.url = url
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}

extension VideoPlayerViewModel {
    struct Input {
    }
    
    struct Output {
    }
}
