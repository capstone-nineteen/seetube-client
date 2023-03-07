//
//  SceneListTableViewCell.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/12.
//

import UIKit
import Kingfisher

class SceneListTableViewCell: UITableViewCell {
    static let cellReuseIdentifier: String = "SceneListTableViewCell"
    static let cellHeight: CGFloat = 80
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var timeIntervalLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var progressBar: CircularProgressBar!
    
    private func bindImage(url: String) {
        let processor = DownsamplingImageProcessor(size: self.thumbnailImageView.bounds.size)
        self.thumbnailImageView.kf.indicatorType = .activity
        self.thumbnailImageView.kf.setImage(
            with: URL(string: url),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.7)),
                .cacheOriginalImage
            ]
        )
    }
    
    func bind(_ viewModel: SceneItemViewModel) {
        self.bindImage(url: viewModel.thumbnailUrl)
        self.timeIntervalLabel.text = viewModel.interval
        self.contentLabel.text = viewModel.description
        
        var color: UIColor? {
            guard let color = viewModel.color else { return Colors.seetubePink }
            switch color {
            case .red: return .red
            case .black: return .black
            case .indigo: return .systemIndigo
            case .yellow: return .yellow
            case .blue: return .blue
            case .orange: return .orange
            case .gray: return .darkGray
            }
        }
        self.progressBar.setProgress(value: viewModel.progress,
                                     text: viewModel.progressDescription,
                                     color: color)
        // TODO: 프로그레스바 색상 변경
    }
    
    func clear() {
        self.thumbnailImageView.kf.cancelDownloadTask()
        self.timeIntervalLabel.text = nil
        self.contentLabel.text = nil
        self.progressBar.setProgress(value: 0,
                                     text: "",
                                     color: nil)
    }
}
