//
//  CategoryButtonStackView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit
import RxCocoa
import RxSwift

class CategoryButtonStackView: UIStackView {
    fileprivate lazy var categoryButtons = Category.allCases.map{
        CategoryButton(category: $0.rawValue)
    }
    
    fileprivate var selectedIndex: Int = 0
    private var disposeBag = DisposeBag()
    
    subscript (index: Int) -> CategoryButton {
        return self.categoryButtons[index]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }
    
    private func configureUI() {
        self.categoryButtons.forEach{ self.addArrangedSubview($0) }
        self.spacing = 8
        
        self.rx.selectedIndex
            .asDriver()
            .drive(with: self) { obj, index in
                obj.highlightButton(index: index)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func highlightButton(index: Int) {
        self.categoryButtons.forEach { $0.backgroundColor = .white }
        self.categoryButtons[index].backgroundColor = .systemGray5
    }
}

extension Reactive where Base: CategoryButtonStackView {
    var selectedIndex: ControlEvent<Int> {
        let taps = Observable.merge(
            base.categoryButtons
                .enumerated()
                .map { index, button in
                    button.rx.tap.map { _ in index }
                }
        )
        
        return ControlEvent(events: taps)
    }
}
