//
//  ResultMenuViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/12.
//

import UIKit
import RxCocoa
import RxSwift

class ResultMenuViewController: UIViewController,
                                ConcentrationResultPushable,
                                EmotionResultPushable,
                                SceneStealerResultPushable,
                                HighlightResultPushable
{
    @IBOutlet weak var concentrationButton: ResultMenuButton!
    @IBOutlet weak var emotionButton: ResultMenuButton!
    @IBOutlet weak var sceneStealerButton: ResultMenuButton!
    @IBOutlet weak var highlightButton: ResultMenuButton!
    
    var videoId: Int?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
}

// MARK: - Configuration

extension ResultMenuViewController {
    private func configureUI() {
        self.configureConcentrationButton()
        self.configureEmotionButton()
        self.configureSceneStealerButton()
        self.configureHighlightButton()
    }
    
    private func configureConcentrationButton() {
        self.concentrationButton.rx.tap
            .asDriver()
            .drive(with: self) { obj, _ in
                guard let videoId = obj.videoId else { return }
                obj.pushConcentrationResult(videoId: videoId)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func configureEmotionButton() {
        self.emotionButton.rx.tap
            .asDriver()
            .drive(with: self) { obj, _ in
                guard let videoId = obj.videoId else { return }
                obj.pushEmotionResult(videoId: videoId)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func configureSceneStealerButton() {
        self.sceneStealerButton.rx.tap
            .asDriver()
            .drive(with: self) { obj, _ in
                guard let videoId = obj.videoId else { return }
                obj.pushSceneStealerResult(videoId: videoId)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func configureHighlightButton() {
        self.highlightButton.rx.tap
            .asDriver()
            .drive(with: self) { obj, _ in
                guard let videoId = obj.videoId else { return }
                obj.pushHighlightResult(videoId: videoId)
            }
            .disposed(by: self.disposeBag)
    }
}
