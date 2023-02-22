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
        
        let input = VideoPlayerViewModel.Input(playTime: playTime,
                                               didPlayToEndTime: didPlayToEndTime)
        let output = viewModel.transform(input: input)
        
        self.bindShouldPlay(output.shouldPlay)
    }
    
    // MARK: Input Event Creation

    private func playTimeProperty() -> Driver<Int> {
        return self.playTime.asDriverIgnoringError()
    }
    
    private func didPlayToEndTimeEvent() -> Driver<Void> {
        return self.didPlayToEndTime.asDriverIgnoringError()
    }
    
    // MARK: Output Binding
    
    private func bindShouldPlay(_ shouldPlay: Driver<Void>) {
        shouldPlay
            .drive(with: self) { obj, _ in
                obj.player?.play()
                // 종료 테스트를 위한 시작 구간 스킵
                obj.player?.seek(to: CMTime(value: 650,
                                            timescale: 1),
                                 toleranceBefore: .zero,
                                 toleranceAfter: .zero)
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Player

extension VideoPlayerViewController {
    private func createPlayer() {
        guard let urlString = self.viewModel?.url,
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
