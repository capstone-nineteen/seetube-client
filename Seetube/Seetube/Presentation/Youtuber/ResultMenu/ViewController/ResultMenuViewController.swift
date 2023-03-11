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
                                SceneStealerResultPushable
{
    @IBOutlet weak var concentrationButton: ResultMenuButton!
    @IBOutlet weak var emotionButton: ResultMenuButton!
    @IBOutlet weak var sceneStealerButton: ResultMenuButton!
    
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
    }
    
    private func configureConcentrationButton() {
        self.concentrationButton.rx.tap
            .asDriver()
            .drive(with: self) { obj, _ in
                // TODO: videoId 주입
                obj.pushConcentrationResult(videoId: 0)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func configureEmotionButton() {
        self.emotionButton.rx.tap
            .asDriver()
            .drive(with: self) { obj, _ in
                // TODO: videoId 주입
                obj.pushEmotionResult(videoId: 0)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func configureSceneStealerButton() {
        self.sceneStealerButton.rx.tap
            .asDriver()
            .drive(with: self) { obj, _ in
                // TODO: videoId 주입
                obj.pushSceneStealerResult(videoId: 0)
            }
            .disposed(by: self.disposeBag)
    }
}
