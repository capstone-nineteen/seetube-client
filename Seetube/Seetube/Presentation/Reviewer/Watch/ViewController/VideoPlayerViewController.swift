//
//  WatchViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/18.
//

import UIKit
import AVFoundation
import RxCocoa
import RxSwift

class VideoPlayerViewController: UIViewController,
                           AlertDisplaying
{
    // Video Player
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private let playTime = PublishRelay<Int>()
    private let didPlayToEndTime = PublishRelay<Void>()
    
    // View Model
    var viewModel: VideoPlayerViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createPlayer()
        self.bindViewModel()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }

    override var shouldAutorotate: Bool {
        return true
    }
}

// MARK: - ViewModel Binding

extension VideoPlayerViewController {
    func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let playTime = self.playTimeProperty()
        let didPlayToEndTime = self.didPlayToEndTimeEvent()
        let videoRect = self.videoRectProperty()
        
        let input = VideoPlayerViewModel.Input(playTime: playTime,
                                               didPlayToEndTime: didPlayToEndTime, videoRect: videoRect)
        let output = viewModel.transform(input: input)
        
        self.bindShouldPlay(output.shouldPlay)
        self.bindShouldStop(output.shouldStop)
    }
    
    // MARK: Input Event Creation

    private func playTimeProperty() -> Driver<Int> {
        return self.playTime.asDriverIgnoringError()
    }
    
    private func didPlayToEndTimeEvent() -> Driver<Void> {
        return self.didPlayToEndTime.asDriverIgnoringError()
    }
    
    private func videoRectProperty() -> Driver<VideoRect> {
        return self.playTime
            .withUnretained(self)
            .map { obj, _ -> CGRect? in
                return obj.playerLayer?.videoRect
            }
            .compactMap { $0 }
            .map { cgRect -> VideoRect in
                return VideoRect(x: Double(cgRect.origin.x),
                                 y: Double(cgRect.origin.y),
                                 width: Double(cgRect.width),
                                 height: Double(cgRect.height))
            }
            .asDriverIgnoringError()
    }
    
    // MARK: Output Binding
    
    private func bindShouldPlay(_ shouldPlay: Driver<Void>) {
        shouldPlay
            .drive(with: self) { obj, _ in
                obj.player?.play()
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindShouldStop(_ shouldStop: Driver<Void>) {
        shouldStop
            .drive(with: self) { obj, _ in
                obj.player?.pause()
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Player

extension VideoPlayerViewController {
    private func createPlayer() {
        guard let urlString = self.viewModel?.url,  // FIXME: ViewModel에서 url Output화
              let url = URL(string: urlString) else { return }

        // AVPlayer
        self.player = AVPlayer(url: url)
        self.player?.preventsDisplaySleepDuringVideoPlayback = true
        
        // AVPlayerLayer
        self.playerLayer = AVPlayerLayer(player: self.player)
        self.playerLayer?.frame = self.view.bounds
        self.view.layer.addSublayer(self.playerLayer!)
        
        self.configureLayout()
        self.configureStop()
        self.addBoundaryTimeObserver()
        self.addVideoEndObserver()
    }
    
    private func configureLayout() {
        self.rx.viewWillLayoutSubviews
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.playerLayer?.frame = self.view.bounds
            }
            .disposed(by: self.disposeBag)
    }
    
    private func configureStop() {
        self.rx.viewDidDisappear
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.player?.pause()
                obj.playerLayer?.removeFromSuperlayer()
            }
            .disposed(by: self.disposeBag)
    }
    
    private func addBoundaryTimeObserver() {
        guard let player = player,
              let duration = player.currentItem?.asset.duration.seconds
        else { return }
        
        let times = (0...Int(duration))
            .map {
                let cmTime = CMTime(seconds: Double($0),
                                    preferredTimescale: 1)
                return NSValue(time: cmTime)
            }
        
        player.addBoundaryTimeObserver(
            forTimes: times,
            queue: nil
        ) { [weak self] in
            let playTime = Int(player.currentTime().seconds)
            self?.playTime.accept(playTime)
        }
    }
    
    private func addVideoEndObserver() {
        // TODO: Subject 제거
        NotificationCenter.default.rx
            .notification(.AVPlayerItemDidPlayToEndTime,
                          object: self.player?.currentItem)
            .map { _ -> Void? in () }
            .asDriver(onErrorJustReturn: nil)
            .compactMap { $0 }
            .drive(with: self) { obj, _ in
                obj.didPlayToEndTime.accept(())
            }
            .disposed(by: self.disposeBag)
    }
}
