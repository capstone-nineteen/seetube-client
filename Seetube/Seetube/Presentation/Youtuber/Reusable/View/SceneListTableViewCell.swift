//
//  SceneListTableViewCell.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/12.
//

import UIKit

class SceneListTableViewCell: UITableViewCell {
    static let cellReuseIdentifier: String = "SceneListTableViewCell"
    static let cellHeight: CGFloat = 80
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var timeIntervalLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var progressBar: CircularProgressBar!
    
    func setProgress(value: Double, text: String?, color: UIColor?) {
        self.progressBar.setProgress(value: value, text: text ?? "", color: color)
    }
}
