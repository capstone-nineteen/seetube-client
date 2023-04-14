//
//  VideoHelper.swift
//  Seetube
//
//  Created by 최수정 on 2023/04/15.
//

import AVFoundation

class VideoHelper {
    static let shared = VideoHelper()
    private init() {}
    
    func getVideoDuration(videoURL: String) -> Int? {
        guard let url = URL(string: videoURL) else { return nil }
        
        let asset = AVAsset(url: url)
        let durationSeconds = CMTimeGetSeconds(asset.duration)
        
        return durationSeconds.isNaN ? nil : Int(durationSeconds)
    }
}
