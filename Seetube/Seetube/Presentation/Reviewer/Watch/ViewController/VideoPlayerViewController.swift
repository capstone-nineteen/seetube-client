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
        
        let input = VideoPlayerViewModel.Input()
        let output = viewModel.transform(input: input)
        
        self.bindShouldPlay(output.shouldPlay)
    }
    
    // MARK: Input Event Creation
    
    private func viewDidLoadEvent() -> Driver<Void> {
        return self.rx.viewDidLoad.asDriver()
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
        print(urlString)
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
        self.rx.viewWillDisappear
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
            print("DEBUG: \(player.currentTime().seconds)")
            // TODO: 1초마다 시선 + 감정 데이터 저장
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
                // TODO: 데이터 서버로 전송 -> 보상 지급 + 얼럿
                obj.finishWatching()
            }
            .disposed(by: self.disposeBag)
    }
    
    private func finishWatching() {
        self.displayOKAlert(
            title: "시청 완료",
            message: "리뷰에 참여해주셔서 감사합니다. 보상이 지급되었습니다."
        ) { [weak self] _ in
            self?.dismiss(animated: true)
        }
    }
}
