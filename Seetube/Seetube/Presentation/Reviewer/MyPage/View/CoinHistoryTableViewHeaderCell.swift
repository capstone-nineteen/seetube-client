//
//  CoinHistoryTableViewHeaderCell.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/19.
//

import UIKit

class CoinHistoryTableViewHeaderCell: UITableViewHeaderFooterView {
    static let headerReuseIdentifier = "CoinHistoryTableViewHeaderCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.automaticallyUpdatesBackgroundConfiguration = false
    }
    
}
