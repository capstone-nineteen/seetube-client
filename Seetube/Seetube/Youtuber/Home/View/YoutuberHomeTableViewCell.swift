//
//  YoutuberHomeTableViewCell.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/20.
//

import UIKit

class YoutuberHomeTableViewCell: UITableViewCell {
    lazy var videoInfoCardView: VideoInfoCardView = {
        let view = VideoInfoCardView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureStyle()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureStyle()
        self.configureLayout()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.videoInfoCardView.alpha = 0.5
        } else {
            self.videoInfoCardView.alpha = 1.0
        }
    }
    
    private func configureStyle() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    private func configureLayout() {
        self.addSubview(self.videoInfoCardView)
        self.videoInfoCardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.videoInfoCardView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.videoInfoCardView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.93),
            self.videoInfoCardView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            self.videoInfoCardView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
