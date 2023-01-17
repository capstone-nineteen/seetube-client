//
//  ShopViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/16.
//

import UIKit

class ShopViewController: UIViewController {
    @IBOutlet weak var receiptView: UIImageView!
    private lazy var totalCoinLabel: AdaptiveFontSizeLabel = {
        let label = AdaptiveFontSizeLabel()
        label.font = label.font.withWeight(.bold)
        label.textAlignment = .right
        label.text = "12,500"
        return label
    }()
    private lazy var balanceCoinLabel: AdaptiveFontSizeLabel = {
        let label = AdaptiveFontSizeLabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .right
        label.text = "2,500"
        return label
    }()
    private lazy var withdrawCoinTextField: UnderLineTextField = {
        let textField = UnderLineTextField()
        textField.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textField.textAlignment = .right
        textField.clearsOnBeginEditing = true
        textField.keyboardType = .numberPad
        textField.text = "10,000"
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureGradientBackground()
        self.configureSubviews()
        self.configureTextField()
    }
}

extension ShopViewController {
    private func configureGradientBackground() {
        guard let accentColor = UIColor(named: "AccentColor")?.cgColor else { return }
        self.view.layer.makeGradientBackground(colors: [accentColor, UIColor.white.cgColor],
                                               locations: [0.0, 1.0],
                                               startPoint: CGPoint(x: 0.0, y: 0.0),
                                               endPoint: CGPoint(x: 0.0, y: 1.0),
                                               type: .axial)
    }
    
    private func configureSubviews() {
        // TODO: total coin label 옆에 별사탕 이미지는 뷰로 구현하도록 수정
        self.receiptView.addSubview(self.totalCoinLabel)
        self.totalCoinLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.totalCoinLabel,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: self.receiptView,
                               attribute: .trailing,
                               multiplier: 0.8,
                               constant: 0),
            NSLayoutConstraint(item: self.totalCoinLabel,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: self.receiptView,
                               attribute: .trailing,
                               multiplier: 0.38,
                               constant: 0),
            NSLayoutConstraint(item: self.totalCoinLabel as Any,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: self.receiptView,
                               attribute: .bottom,
                               multiplier: 0.44,
                               constant: 0),
            self.totalCoinLabel.heightAnchor.constraint(equalTo: self.receiptView.heightAnchor, multiplier: 0.08)
        ])
        
        self.receiptView.addSubview(self.balanceCoinLabel)
        self.balanceCoinLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.balanceCoinLabel,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: self.receiptView,
                               attribute: .trailing,
                               multiplier: 0.83,
                               constant: 0),
            NSLayoutConstraint(item: self.balanceCoinLabel,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: self.receiptView,
                               attribute: .trailing,
                               multiplier: 0.62,
                               constant: 0),
            NSLayoutConstraint(item: self.balanceCoinLabel as Any,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: self.receiptView,
                               attribute: .bottom,
                               multiplier: 0.74,
                               constant: 0),
            self.balanceCoinLabel.heightAnchor.constraint(equalTo: self.receiptView.heightAnchor, multiplier: 0.038)
        ])
        
        self.receiptView.addSubview(withdrawCoinTextField)
        self.withdrawCoinTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.withdrawCoinTextField as Any,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: self.receiptView,
                               attribute: .bottom,
                               multiplier: 0.67,
                               constant: 0),
            self.withdrawCoinTextField.leadingAnchor.constraint(equalTo: self.balanceCoinLabel.leadingAnchor),
            self.withdrawCoinTextField.trailingAnchor.constraint(equalTo: self.balanceCoinLabel.trailingAnchor),
            self.withdrawCoinTextField.heightAnchor.constraint(equalTo: self.balanceCoinLabel.heightAnchor)
        ])
    }
}

extension ShopViewController {
    private func configureTextField() {
        self.withdrawCoinTextField.delegate = self
        self.withdrawCoinTextField.addTarget(self,
                                             action: #selector(textFieldEditingChanged(_:)),
                                             for: .editingChanged)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        guard let textWithoutSeparator = textField.text?.replacingOccurrences(of: ",", with: "") else { return }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let numberWithSeparator = formatter.number(from: textWithoutSeparator) {
            textField.text = formatter.string(from: numberWithSeparator)
        }
    }
}

extension ShopViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = textField.text == "" ? "0" : textField.text
    }
}
