//
//  ReviewerHomeCollectionView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/30.
//

import UIKit

class ReviewerHomeCollectionView: UICollectionView {
    private(set) var category: Category = .all
    
    func configureCategory(_ category: Category) {
        self.category = category
    }
}
