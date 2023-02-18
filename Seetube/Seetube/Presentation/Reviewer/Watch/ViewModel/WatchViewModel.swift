//
//  WatchViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/18.
//

import Foundation

class WatchViewModel: ViewModelType {
    let url: String
    
    init(url: String) {
        // TODO: S3 권한 요청 후 Info.plist NSAppTransportSecurity 삭제
        self.url = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}

extension WatchViewModel {
    struct Input {
    }
    
    struct Output {
    }
}
