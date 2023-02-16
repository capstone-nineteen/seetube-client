//
//  CategoryButtonScrollView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit
import RxCocoa
import RxSwift

@IBDesignable
class CategoryButtonScrollView: UIScrollView {
    fileprivate lazy var categoryButtonStackView = CategoryButtonStackView()
    
    fileprivate let selectedIndex = PublishRelay<Int>()
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureSubviews()
        self.bindUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureSubviews()
        self.bindUI()
    }
    
    private func configureSubviews() {
        self.addSubview(self.categoryButtonStackView)
        self.categoryButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.categoryButtonStackView.leadingAnchor.constraint(equalTo: self.contentLayoutGuide.leadingAnchor),
            self.categoryButtonStackView.bottomAnchor.constraint(equalTo: self.contentLayoutGuide.bottomAnchor),
            self.categoryButtonStackView.trailingAnchor.constraint(equalTo: self.contentLayoutGuide.trailingAnchor),
            self.categoryButtonStackView.topAnchor.constraint(equalTo: self.contentLayoutGuide.topAnchor),
            self.categoryButtonStackView.heightAnchor.constraint(equalTo: self.frameLayoutGuide.heightAnchor)
        ])
    }
    
    private func bindUI() {
        self.categoryButtonStackView.rx.selectedIndex
            .asDriver()
            .drive(with: self) { obj, index in
                self.centerButton(index: index)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func centerButton(index: Int) {
        let button = self.categoryButtonStackView[index]
        let maximumXOffset = self.categoryButtonStackView.bounds.width - self.bounds.width
        let buttonCenterXOffset = button.frame.midX - self.bounds.width / 2

        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: [.allowAnimatedContent]
        ) {
            self.contentOffset = CGPoint(
                x: min(maximumXOffset, max(0, buttonCenterXOffset)),
                y: 0
            )
        } completion: { _ in
            // animation이 끝나기 전에 테이블뷰가 리로드되어버리면 애니메이션 겹쳐서 센터링이 안됨
            // animation이 끝나고 방출해주어야 테이블뷰 리로드와 겹치지 않는다
            self.selectedIndex.accept(index)
        }
    }
}

// MARK: - Reactive Extension

extension Reactive where Base: CategoryButtonScrollView {
    var selectedIndex: ControlProperty<Int> {
        let source = base.selectedIndex.asObservable()
        let binder = base.categoryButtonStackView.rx.selectedIndex
        
        return ControlProperty(values: source,
                               valueSink: binder)
    }
}
