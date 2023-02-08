//
//  ReviewerHomeSectionView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/30.
//

import UIKit

protocol SeeAllButtonDelegate: AnyObject {
    func seeAllButtonTouched(category: Category)
}

class ReviewerHomeSectionView: UIView, NibLoadable {
    private(set) var category: Category = .all
    private weak var delegate: SeeAllButtonDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: ReviewerHomeCollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
        self.configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadFromNib(owner: self)
        self.configureCollectionView()
    }
    
    @IBAction func seeAllButtonTouched(_ sender: UIButton) {
        self.delegate?.seeAllButtonTouched(category: self.category)
    }
    
    private func configureCollectionView() {
        self.collectionView.register(ReviewerHomeCollectionViewCell.self, forCellWithReuseIdentifier: ReviewerHomeCollectionViewCell.cellReuseIdentifier)
    }
    
    func configureDelegate(_ delegate: SeeAllButtonDelegate & UICollectionViewDelegate & UICollectionViewDataSource) {
        self.delegate = delegate
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = delegate
    }
    
    func configureCategory(_ category: Category) {
        self.collectionView.configureCategory(category)
        self.category = category
        self.titleLabel.text = (category == .all) ? "새로운 영상": category.rawValue
    }
}
