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

class WatchViewController: UIViewController {
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    var viewModel: WatchViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurePlayer()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }

    override var shouldAutorotate: Bool {
        return true
    }
}

// MARK: - Configuration

extension WatchViewController {
    private func configurePlayer() {
        guard let urlString = self.viewModel?.url,
              let url = URL(string: urlString) else { return }

        // AVPlayer
        player = AVPlayer(url: url)
        
        // AVPlayerLayer
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = self.view.bounds
        view.layer.addSublayer(playerLayer!)
        
        self.rx.viewWillDisappear
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.player?.pause()
                obj.playerLayer?.removeFromSuperlayer()
            }
            .disposed(by: self.disposeBag)
        
        self.rx.viewWillLayoutSubviews
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.playerLayer?.frame = self.view.bounds
            }
            .disposed(by: self.disposeBag)
        
        self.rx.viewDidAppear
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.player?.play()
            }
            .disposed(by: self.disposeBag)
    }
}
