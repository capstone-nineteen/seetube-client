//
//  ListStyleResultView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/14.
//

import UIKit
import RxSwift
import RxCocoa

class ListStyleResultView: UIView, NibLoadable {
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
    
    func bind(with viewModels: Driver<[SceneItemViewModel]>) -> Disposable {
        return self.sceneListView.bind(with: viewModels)
    }
}

// MARK: - Reactive Extension

extension Reactive where Base: ListStyleResultView {
    var tableViewItemSelected: ControlEvent<IndexPath> {
        return base.sceneListView.rx.tableViewItemSelected
    }
}
