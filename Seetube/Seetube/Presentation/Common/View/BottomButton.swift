//
//  BottomButton.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/14.
//

import UIKit
import RxCocoa
import RxSwift

@IBDesignable
class BottomButton: UIButton, NibLoadable {
    @IBOutlet private var contentView: UIView!
    @IBOutlet fileprivate weak var nameLabel: AdaptiveFontSizeLabel!
    @IBInspectable var name: String? {
        get { self.nameLabel.text }
        set { self.nameLabel.text = newValue }
    }
    private var disposeBag = DisposeBag()
    
    override var isHighlighted: Bool {
        didSet {
            self.alpha = isHighlighted ? 0.7 : 1.0
        }
    }
    override var isEnabled: Bool {
        didSet {
            let enabledColor = Colors.seetubePink
            let disabledColor = UIColor.systemGray2
            self.contentView.backgroundColor = self.isEnabled ? enabledColor : disabledColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
        self.configureShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadFromNib(owner: self)
        self.configureShadow()
    }
}

extension Reactive where Base: BottomButton {
    var text: Binder<String?> {
        Binder(base) { obj, text in
            obj.name = text
        }
    }
}
