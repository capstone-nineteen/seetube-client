//
//  ConcentrationResultViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/12.
//

import UIKit
import RxCocoa
import RxSwift
import AVFoundation

class ConcentrationResultViewController: UIViewController {
    @IBOutlet weak var resultView: ListStyleResultView!
    
    // Video Player
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private var timeObserver: Any?
    
    // View Model
    var viewModel: ConcentrationResultViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
}

// MARK: - ViewModel Binding

extension ConcentrationResultViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let viewWillAppear = self.viewWillAppearEvent()
        let itemSelected = self.itemSelectedEvent()
        
        let input = ConcentrationResultViewModel.Input(
            viewWillAppear: viewWillAppear,
            itemSelected: itemSelected
        )
        let output = viewModel.transform(input: input)
        
        self.bindVideoUrl(output.videoUrl)
        self.bindScenes(output.scenes)
        self.bindPlayingInterval(output.playingInterval)
    }
    
    // MARK: Input Event Creation
    
    private func viewWillAppearEvent() -> Driver<Bool> {
        return self.rx.viewWillAppear.asDriver()
    }
    
    private func itemSelectedEvent() -> Driver<IndexPath> {
        return self.resultView.rx.tableViewItemSelected.asDriver()
    }
    
    // MARK: Output Binding
    
    private func bindVideoUrl(_ url: Driver<String>) {
        url
            .drive(with: self) { obj, url in
                obj.createPlayer(url: url)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindScenes(_ scenes: Driver<[SceneItemViewModel]>) {
        self.resultView
            .bind(with: scenes)
            .disposed(by: self.disposeBag)
    }
    
    private func bindPlayingInterval(_ interval: Driver<(start: Int, end: Int)>) {
        interval
            .drive(with: self) { obj, interval in
                obj.playInterval(start: interval.start,
                                 end: interval.end)
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Video Player

extension ConcentrationResultViewController {
    private func createPlayer(url: String) {
        guard let url = URL(string: url) else { return }

        // AVPlayer
        let asset = AVURLAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        self.player = AVPlayer(playerItem: playerItem)
        self.player?.preventsDisplaySleepDuringVideoPlayback = true
        
        // AVPlayerLayer
        self.playerLayer = AVPlayerLayer(player: self.player)
        guard let playerLayer = self.playerLayer else { return }
        self.resultView.addAVPlayerLayer(playerLayer)
        playerLayer.isHidden = true
    }
    
    private func playInterval(start: Int, end: Int) {
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
        
        self.play()
    }
    
    private func pause() {
        DispatchQueue.main.async {
            self.playerLayer?.isHidden = true
            self.player?.pause()
        }
    }
    
    private func play() {
        DispatchQueue.main.async {
            self.player?.play()
            self.playerLayer?.isHidden = false
        }
    }
    
    private func removeTimeObserver() {
        guard let currentObserver = self.timeObserver else { return }
        self.player?.removeTimeObserver(currentObserver)
        self.timeObserver = nil
    }
}
