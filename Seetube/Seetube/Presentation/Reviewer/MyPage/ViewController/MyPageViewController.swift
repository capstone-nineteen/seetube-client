//
//  MyPageViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/18.
//

import UIKit
import RxSwift
import RxViewController
import RxCocoa

class MyPageViewController: UIViewController,
                            StartScreenReturnable
{
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var signOutButton: UIButton!
    
    var viewModel: MyPageViewModel?
    private var disposeBag = DisposeBag()
    private var signOutConfirmButtonTouched = PublishRelay<Void>()    // confirm alert의 OK 버튼과 연결된 Relay
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
    }
}

// MARK: - Configuration

extension MyPageViewController {
    private func configureUI() {
        self.configureBackgroundView()
        self.configureTableView()
        self.configureSignOutButton()
    }
    
    private func configureBackgroundView() {
        self.backgroundView.configureShadow(alpha: 0.5, radius: 5)
    }
    
    private func configureTableView() {
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0.0
        } else {
            self.tableView.contentInset = UIEdgeInsets(top: -35,
                                                       left: 0,
                                                       bottom: 0,
                                                       right: 0)
        }
        
        self.tableView.register(
            UINib(nibName: CoinHistoryTableViewHeaderCell.headerReuseIdentifier, bundle: nil),
            forHeaderFooterViewReuseIdentifier: CoinHistoryTableViewHeaderCell.headerReuseIdentifier
        )
    }
    
    private func configureSignOutButton() {
        self.signOutButton.rx.tap
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.displayConfirmSignOutAlert()
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - ViewModel Binding

extension MyPageViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let viewWillAppear = self.viewWillAppearEvent()
        let signOutButtonTouched = self.signOutConfirmButtonTouchedEvent()
        
        let input = MyPageViewModel.Input(viewWillAppear: viewWillAppear,
                                          signOutButtonTouched: signOutButtonTouched)
        let output = viewModel.transform(input: input)
        
        self.bindName(output.name)
        self.bindCoin(output.coin)
        self.bindCoinHistories(output.coinHistories)
        self.bindDidSignOut(output.didSignOut)
    }
    
    // MARK: Input Creation
    
    private func viewWillAppearEvent() -> Driver<Bool> {
        return self.rx.viewWillAppear.asDriver()
    }
    
    private func signOutConfirmButtonTouchedEvent() -> Driver<Void> {
        return self.signOutConfirmButtonTouched.asDriverIgnoringError()
    }
    
    // MARK: Output Binding
    
    private func bindName(_ name: Driver<String>) {
        name
            .drive(self.nameLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
    
    private func bindCoin(_ coin: Driver<String>) {
        coin
            .drive(self.coinLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
    
    private func bindCoinHistories(_ coinHistories: Driver<[CoinHistoryItemViewModel]>) {
        coinHistories
            .drive(
                self.tableView.rx.items(
                    cellIdentifier: CoinHistoryTableViewCell.cellReuseIdentifier,
                    cellType: CoinHistoryTableViewCell.self
                )
            ) { row, viewModel, cell in
                cell.bind(viewModel)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindDidSignOut(_ didSignOut: Driver<Void>) {
        didSignOut
            .drive(with: self) { obj, _ in
                obj.returnToStartScreen()
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

// MARK: - Alerts

extension MyPageViewController: AlertDisplaying {
    private func displayConfirmSignOutAlert() {
        self.displayAlertWithAction(title: "로그아웃",
                                    message: "로그아웃 하시겠습니까?") { [weak self] _ in
            self?.signOutConfirmButtonTouched.accept(())
        }
    }
}
