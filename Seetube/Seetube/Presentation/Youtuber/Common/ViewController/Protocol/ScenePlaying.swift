//
//  ScenePlaying.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/07.
//

import UIKit
import AVFoundation

protocol AVPlayerLayerAddable: UIView {
    func addAVPlayerLayer(_ playerLayer: AVPlayerLayer)
}

protocol ScenePlaying: UIViewController {
    var player: AVPlayer? { get set }
    var playerLayer: AVPlayerLayer? { get set }
    var timeObserver: Any? { get set }
    
    func createPlayer(url: String, at view: AVPlayerLayerAddable)
    func playInterval(start: Int, end: Int)
    func pause()
    func play()
    func removeTimeObserver()
}

extension ScenePlaying {
    func createPlayer(url: String, at view: AVPlayerLayerAddable) {
        guard let url = URL(string: url) else { return }

        // AVPlayer
        let asset = AVURLAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        self.player = AVPlayer(playerItem: playerItem)
        self.player?.preventsDisplaySleepDuringVideoPlayback = true
        
        // AVPlayerLayer
        self.playerLayer = AVPlayerLayer(player: self.player)
        guard let playerLayer = self.playerLayer else { return }
        view.addAVPlayerLayer(playerLayer)
        playerLayer.isHidden = true
    }
    
    func playInterval(start: Int, end: Int) {
        self.pause()
        
        let startTime = CMTime(seconds: Double(start),
                               preferredTimescale: 1)
        let endTime = CMTime(seconds: Double(end),
                             preferredTimescale: 1)
        
        // 시작 시각으로 이동
        self.player?.seek(to: startTime)
        
        // 종료 시각 도달 시 재생 중지
        self.removeTimeObserver()
        self.timeObserver = self.player?.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 1.0, preferredTimescale: 600),
            queue: .global(qos: .background)
        ) { [weak self] time in
            if time >= endTime {
                self?.pause()
                self?.removeTimeObserver()
            }
        }
        
        // FIXME: 장면 변경 시 중복 hidden 처리되어 영상이 보이지 않는 버그 있음
        self.play()
    }
    
    func pause() {
        DispatchQueue.main.async {
            self.playerLayer?.isHidden = true
            self.player?.pause()
        }
    }
    
    func play() {
        DispatchQueue.main.async {
            self.player?.play()
            self.playerLayer?.isHidden = false
        }
    }
    
    func removeTimeObserver() {
        guard let currentObserver = self.timeObserver else { return }
        self.player?.removeTimeObserver(currentObserver)
        self.timeObserver = nil
    }
}
