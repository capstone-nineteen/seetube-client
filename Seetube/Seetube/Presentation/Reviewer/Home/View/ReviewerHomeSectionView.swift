//
//  ReviewerHomeSectionView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/30.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftUI

class ReviewerHomeSectionView: UIView, NibLoadable {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var seeAllButton: UIButton!
    @IBOutlet fileprivate weak var collectionView: ReviewerHomeCollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
        self.registerCollectionViewCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadFromNib(owner: self)
        self.registerCollectionViewCell()
    }
    
    func registerCollectionViewCell() {
        self.collectionView.register(
            ReviewerHomeCollectionViewCell.self,
            forCellWithReuseIdentifier: ReviewerHomeCollectionViewCell.cellReuseIdentifier
        )
    }
    
    func bind(with viewModel: Driver<ReviewerHomeSectionViewModel>) -> Cancelable {
        return Disposables.create(
            viewModel
                .map { $0.title }
                .drive(self.titleLabel.rx.text),
            viewModel
                .map { $0.videos }
                .drive(
                    self.collectionView.rx.items(
                        cellIdentifier: ReviewerHomeCollectionViewCell.cellReuseIdentifier,
                        cellType: ReviewerHomeCollectionViewCell.self
                    )
                ) { row, viewModel, cell in
                    cell.bind(viewModel)
                }
        )
    }
}

extension Reactive where Base: ReviewerHomeSectionView {
    var collectionViewItemSelected: ControlEvent<IndexPath> {
        return base.collectionView.rx.itemSelected
    }
    
    var seeAllButtonTouched: ControlEvent<Void> {
        return base.seeAllButton.rx.tap
    }
}
