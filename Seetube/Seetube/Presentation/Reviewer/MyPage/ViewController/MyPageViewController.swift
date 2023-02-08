//
//  MyPageViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/18.
//

import UIKit

class MyPageViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureBackgroundView()
        self.configureTableView()
    }
}

extension MyPageViewController {
    private func configureBackgroundView() {
        self.backgroundView.configureShadow(alpha: 0.5, radius: 5)
    }
    
    private func configureTableView() {
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0.0
        } else {
            self.tableView.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)
        }
        
        self.tableView.register(UINib(nibName: CoinHistoryTableViewHeaderCell.headerReuseIdentifier, bundle: nil),
                                forHeaderFooterViewReuseIdentifier: CoinHistoryTableViewHeaderCell.headerReuseIdentifier)
    }
}

extension MyPageViewController: UITableViewDelegate {
    
}

extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CoinHistoryTableViewHeaderCell.headerReuseIdentifier) as? CoinHistoryTableViewHeaderCell else { return UITableViewHeaderFooterView() }
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinHistoryTableViewCell.cellReuseIdentifier, for: indexPath) as? CoinHistoryTableViewCell else { return UITableViewCell() }
        return cell
    }
}
