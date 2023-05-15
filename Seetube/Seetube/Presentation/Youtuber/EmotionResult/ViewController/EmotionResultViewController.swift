//
//  EmotionResultViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/13.
//

import UIKit
import RxCocoa
import RxSwift
import AVFoundation

class EmotionResultViewController: UIViewController,
                                   SceneResultViewModelBindable
{
    @IBOutlet weak var resultView: ListStyleResultView!
    
    // Video Player
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var timeObserver: Any?
    
    // View Model
    var viewModel: SceneResultViewModel?
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.removePlayer()
    }
}
