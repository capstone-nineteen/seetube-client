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
    fileprivate var categoryButtons = Category.allCases.map{
        CategoryButton(category: $0.rawValue)
    }
    
    fileprivate let programaticallySelected = PublishRelay<Int>()
    private var disposeBag = DisposeBag()
    
    subscript (index: Int) -> CategoryButton {
        return self.categoryButtons[index]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.bindUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.bindUI()
    }
    
    private func bindUI() {
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

// MARK: - Reactive Extension

extension Reactive where Base: CategoryButtonStackView {
    var selectedIndex: ControlProperty<Int> {
        let taps = Observable
            .merge(
                base.categoryButtons
                    .enumerated()
                    .map { index, button in
                        button.rx.tap.map { _ in index }
                    }
            )
        // (탭 컨트롤이벤트) + (binder를 통해 코드로 주입한 값)
        let source = Observable
            .merge(
                base.programaticallySelected.asObservable(),
                taps
            )
            .debounce(.milliseconds(5),
                   scheduler: MainScheduler.asyncInstance)
        let binder = Binder(base) { obj, index in
            base.programaticallySelected.accept(index)
        }
        
        return ControlProperty(values: source,
                               valueSink: binder)
    }
}
