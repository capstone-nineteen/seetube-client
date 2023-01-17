//
//  UnderLineTextField.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/17.
//

import UIKit

class UnderLineTextField: UITextField {
    private let inactiveColor: UIColor = .systemGray4
    private let activeColor: UIColor = .darkGray
    
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

    private func configureUnderLineView() {
        self.addSubview(self.underLineView)
        self.underLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.underLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.underLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.underLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.underLineView.heightAnchor.constraint(equalToConstant: 1.5)
        ])
        
        self.addTarget(self, action: #selector(changeColorToActive), for: .editingDidBegin)
        self.addTarget(self, action: #selector(changeColorToInactive), for: .editingDidEnd)
    }
    
    @objc func changeColorToActive() {
        self.underLineView.backgroundColor = self.activeColor
    }
    
    @objc func changeColorToInactive() {
        self.underLineView.backgroundColor = self.inactiveColor
    }
}
