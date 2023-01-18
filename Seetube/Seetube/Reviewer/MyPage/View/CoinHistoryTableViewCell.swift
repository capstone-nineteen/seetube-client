//
//  CoinHistoryTableViewCell.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/18.
//

import UIKit

class CoinHistoryTableViewCell: UITableViewCell {
    static let cellReuseIdentifier: String = "CoinHistoryTableViewCell"
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var coinAmountLabel: UILabel!
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
