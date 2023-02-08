//
//  UnderLineSegmentedControl.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/19.
//

import UIKit

class UnderlineSegmentedControl: UISegmentedControl {
    private lazy var underline: UIView = UIView()
    private lazy var selectedUnderline: UIView = UIView()
    
    @IBInspectable var selectedColor: UIColor? {
        didSet {
            self.setSelectedColor(color: self.selectedColor)
        }
    }
    
    private var underlineLeadingConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureLayout()
        self.configureSegmentedControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureLayout()
        self.configureSegmentedControl()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.cornerRadius = 0
        let leading = self.selectedUnderline.bounds.width * CGFloat(self.selectedSegmentIndex)
        self.underlineLeadingConstraint?.constant = leading
    }
    
    private func configureLayout() {
        self.addSubview(self.underline)
        self.underline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.underline.heightAnchor.constraint(equalToConstant: 2),
            self.underline.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.underline.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.underline.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.addSubview(self.selectedUnderline)
        self.selectedUnderline.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = self.selectedUnderline.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
        self.underlineLeadingConstraint = leadingConstraint
        NSLayoutConstraint.activate([
            self.selectedUnderline.heightAnchor.constraint(equalTo: self.underline.heightAnchor),
            self.selectedUnderline.bottomAnchor.constraint(equalTo: self.underline.bottomAnchor),
            self.selectedUnderline.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/CGFloat(self.numberOfSegments)),
            leadingConstraint
        ])
    }
    
    private func configureSegmentedControl() {
        self.removeDefaultDivider()
        self.removeDefaultBackground()
        self.setNormalColor()
    }
    
    private func removeDefaultBackground() {
        let image = UIImage()
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
    }
    
    private func removeDefaultDivider() {
        let image = UIImage()
        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
    private func setNormalColor() {
        self.underline.backgroundColor = UIColor.systemGray5
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemGray2], for: .normal)
    }
    
    private func setSelectedColor(color: UIColor?) {
        self.selectedUnderline.backgroundColor = color
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor ?? UIColor.label],
                                    for: .selected)
    }
}
