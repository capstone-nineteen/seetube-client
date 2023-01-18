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
    
    private lazy var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = self.inactiveColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUnderLineView()
        self.configureFontSize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUnderLineView()
        self.configureFontSize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.font = self.font?.withSize(self.bounds.height * 0.7)
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
    
    private func configureFontSize() {
        self.adjustsFontSizeToFitWidth = false
        self.minimumFontSize = 1
    }
    
    @objc private func changeColorToActive() {
        self.underLineView.backgroundColor = self.activeColor
    }
    
    @objc private func changeColorToInactive() {
        self.underLineView.backgroundColor = self.inactiveColor
    }
}
