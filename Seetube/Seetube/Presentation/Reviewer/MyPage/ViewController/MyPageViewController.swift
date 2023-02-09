//
//  MyPageViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/18.
//

import UIKit
import RxSwift
import RxViewController

class MyPageViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MyPageViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
        self.bind()
    }
}

// MARK: - Configuration
extension MyPageViewController {
    private func configureViews() {
        self.configureBackgroundView()
        self.configureTableView()
    }
    
    private func configureBackgroundView() {
        self.backgroundView.configureShadow(alpha: 0.5, radius: 5)
    }
    
    private func configureTableView() {
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0.0
        } else {
            self.tableView.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)
        }
        
        self.tableView.register(
            UINib(nibName: CoinHistoryTableViewHeaderCell.headerReuseIdentifier, bundle: nil),
            forHeaderFooterViewReuseIdentifier: CoinHistoryTableViewHeaderCell.headerReuseIdentifier
        )
    }
}

// MARK: - Binding
extension MyPageViewController {
    private func bind() {
        guard let viewModel = self.viewModel else { return }
        
        let input = MyPageViewModel.Input(viewWillAppear: self.rx.viewWillAppear.asDriver())
        let output = viewModel.transform(input: input)
        
        output.name
            .drive(self.nameLabel.rx.text)
            .disposed(by: self.disposeBag)
        output.coin
            .drive(self.coinLabel.rx.text)
            .disposed(by: self.disposeBag)
        output.coinHistories
            .drive(
                self.tableView.rx.items(cellIdentifier: CoinHistoryTableViewCell.cellReuseIdentifier,
                                        cellType: CoinHistoryTableViewCell.self)
            ) { index, viewModel, cell in
                cell.bind(viewModel)
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - UITableViewDelegate
extension MyPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        CoinHistoryTableViewHeaderCell.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: CoinHistoryTableViewHeaderCell.headerReuseIdentifier
        ) as? CoinHistoryTableViewHeaderCell else {
            return UITableViewHeaderFooterView()
        }
        return header
    }
}
