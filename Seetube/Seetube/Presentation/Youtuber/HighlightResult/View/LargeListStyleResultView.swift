//
//  LargeListStyleResultView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/14.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation

class LargeListStyleResultView: UIView, NibLoadable {
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var sceneListView: SceneListLargeView!
    
    @IBInspectable var title: String? {
        set { self.sceneListView.updateTitle(with: newValue) }
        get { return self.sceneListView.title }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadFromNib(owner: self)
    }
    
    func bind(with viewModels: Driver<[SceneLargeItemViewModel]>) -> Disposable {
        return self.sceneListView.bind(with: viewModels)
    }
}

// MARK: - AVPlayerLayerAddable

extension LargeListStyleResultView: AVPlayerLayerAddable {
    func addAVPlayerLayer(_ playerLayer: AVPlayerLayer) {
        playerLayer.frame = self.videoView.bounds
        self.videoView.layer.addSublayer(playerLayer)
    }
}

// MARK: - Reactive Extension

extension Reactive where Base: LargeListStyleResultView {
    var tableViewItemSelected: ControlEvent<IndexPath> {
        return base.sceneListView.rx.tableViewItemSelected
    }
}
