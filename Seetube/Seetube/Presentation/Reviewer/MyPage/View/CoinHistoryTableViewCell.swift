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
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var coinAmountLabel: UILabel!
    
    override func prepareForReuse() {
        self.dateLabel.text = ""
        self.contentLabel.text = ""
        self.coinAmountLabel.text = ""
        self.coinAmountLabel.textColor = .black
    }
    
    func bind(_ viewModel: CoinHistoryViewModel) {
        self.dateLabel.text = viewModel.date
        self.contentLabel.text = viewModel.content
        self.coinAmountLabel.text = viewModel.amount
        switch viewModel.type {
        case .use:
            self.coinAmountLabel.textColor = .black
        case .earn:
            self.coinAmountLabel.textColor = Colors.seetubePink
        }
    }
}
