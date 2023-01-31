//
//  VideoInfoCardView.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/19.
//

import UIKit

@IBDesignable
class VideoInfoCardView: UIView, NibLoadable {
    @IBOutlet weak var videoTitleLabel: AdaptiveFontSizeLabel!
    @IBOutlet weak var youtuberNameTitle: AdaptiveFontSizeLabel!
    @IBOutlet weak var dateLabel: AdaptiveFontSizeLabel!
    @IBOutlet weak var personnelLabel: AdaptiveFontSizeLabel!
    @IBOutlet weak var accesoryView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib(owner: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadFromNib(owner: self)
    }
    
    func configureAccessoryView(_ view: UIView) {
        self.accesoryView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.accesoryView.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.accesoryView.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: self.accesoryView.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: self.accesoryView.trailingAnchor)
        ])
    }
}
