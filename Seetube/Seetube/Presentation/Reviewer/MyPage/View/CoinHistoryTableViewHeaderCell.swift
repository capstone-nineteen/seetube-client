//
//  CoinHistoryTableViewHeaderCell.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/19.
//

import UIKit

class CoinHistoryTableViewHeaderCell: UITableViewHeaderFooterView {
    static let headerReuseIdentifier = "CoinHistoryTableViewHeaderCell"
    static let height: CGFloat = 35.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.automaticallyUpdatesBackgroundConfiguration = false
    }
}
