//
//  UnderLineTextField.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/17.
//

import UIKit

@IBDesignable
class UnderLineTextField: UITextField {
    private let inactiveColor: UIColor = .systemGray4
    private let activeColor: UIColor = UIColor(named: "AccentColor") ?? .darkGray
    
    @IBInspectable var isPasteEnabled: Bool = true
    @IBInspectable var isSelectEnabled: Bool = true
    @IBInspectable var isSelectAllEnabled: Bool = true
    @IBInspectable var isCopyEnabled: Bool = true
    @IBInspectable var isCutEnabled: Bool = true
    @IBInspectable var isDeleteEnabled: Bool = true
    
    private lazy var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = self.inactiveColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUnderLineView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUnderLineView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.font = self.font?.withSize(self.bounds.height * 0.7)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        switch action {
        case #selector(UIResponderStandardEditActions.paste(_:)) where !isPasteEnabled,
             #selector(UIResponderStandardEditActions.select(_:)) where !isSelectEnabled,
             #selector(UIResponderStandardEditActions.selectAll(_:)) where !isSelectAllEnabled,
             #selector(UIResponderStandardEditActions.copy(_:)) where !isCopyEnabled,
             #selector(UIResponderStandardEditActions.cut(_:)) where !isCutEnabled,
             #selector(UIResponderStandardEditActions.delete(_:)) where !isDeleteEnabled:
            return false
        default:
            return super.canPerformAction(action, withSender: sender)
        }
    }

    private func configureUnderLineView() {
        self.addSubview(self.underLineView)
        self.underLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.underLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 2),
            self.underLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.underLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 3),
            self.underLineView.heightAnchor.constraint(equalToConstant: 1.5)
        ])
        
        self.addTarget(self, action: #selector(changeColorToActive), for: .editingDidBegin)
        self.addTarget(self, action: #selector(changeColorToInactive), for: .editingDidEnd)
    }
    
    @objc private func changeColorToActive() {
        self.underLineView.backgroundColor = self.activeColor
    }
    
    @objc private func changeColorToInactive() {
        self.underLineView.backgroundColor = self.inactiveColor
    }
}
