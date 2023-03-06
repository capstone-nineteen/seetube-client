//
//  ListStyleResultView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/14.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation

class ListStyleResultView: UIView, NibLoadable {
    @IBOutlet weak var videoView: UIView!
    @IBOutlet fileprivate weak var sceneListView: SceneListView!
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.videoView.layer.sublayers?.forEach { [weak self] in
            guard let self = self else { return }
            $0.frame = self.videoView.bounds
        }
    }
    
    func bind(with viewModels: Driver<[SceneItemViewModel]>) -> Disposable {
        return self.sceneListView.bind(with: viewModels)
    }
    
    func addAVPlayerLayer(_ playerLayer: AVPlayerLayer) {
        playerLayer.frame = self.videoView.bounds
        self.videoView.layer.addSublayer(playerLayer)
    }
}

// MARK: - Reactive Extension

extension Reactive where Base: ListStyleResultView {
    var tableViewItemSelected: ControlEvent<IndexPath> {
        return base.sceneListView.rx.tableViewItemSelected
    }
}
