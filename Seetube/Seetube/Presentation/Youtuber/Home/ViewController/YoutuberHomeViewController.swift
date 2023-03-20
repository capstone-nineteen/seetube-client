//
//  YoutuberHomeViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/19.
//

import UIKit
import RxCocoa
import RxSwift

class YoutuberHomeViewController: UIViewController,
                                  YoutuberVideoDetailPushable,
                                  ResultMenuPushable,
                                  StartScreenReturnable,
                                  AlertDisplaying
{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var segmentedControl: UnderlineSegmentedControl!
    @IBOutlet weak var finishedReviewsView: UIView!
    @IBOutlet weak var reviewsInProgressView: UIView!
    @IBOutlet weak var signOutButton: UIButton!
    
    private var finishedReviewsTableViewController: FinishedReviewsTableViewController? {
        self.children[1] as? FinishedReviewsTableViewController
    }
    private var reviewsInProgressTableViewController: ReviewsInProgressTableViewController? {
        self.children[0] as? ReviewsInProgressTableViewController
    }
    
    var viewModel: YoutuberHomeViewModel?
    private var disposeBag = DisposeBag()
    private var signOutConfirmButtonTouched = PublishRelay<Void>()    // confirm alert의 OK 버튼과 연결된 Relay
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
    }
}

// MARK: - Configuration

extension YoutuberHomeViewController {
    private func configureUI() {
        self.configureNavigationBar()
        self.configureSegmentedControl()
        self.configureSignOutButton()
    }
    
    private func configureSegmentedControl() {
        self.segmentedControl.rx.selectedSegmentIndex
            .asDriver()
            .drive(with: self) { obj, index in
                switch index {
                case 0:
                    obj.finishedReviewsView.isHidden = false
                    obj.reviewsInProgressView.isHidden = true
                case 1:
                    obj.finishedReviewsView.isHidden = true
                    obj.reviewsInProgressView.isHidden = false
                default:
                    return
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    private func configureNavigationBar() {
        self.rx.viewWillAppear
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.navigationController?.isNavigationBarHidden = true
            }
            .disposed(by: self.disposeBag)
        
        self.rx.viewWillDisappear
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.navigationController?.isNavigationBarHidden = false
            }
            .disposed(by: self.disposeBag)
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

extension YoutuberHomeViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let viewWillAppear = self.viewWillAppearEvent()
        let selectedFinishedReviewItem = self.selectedFinishedReviewItem()
        let selectedReviewInProgressItem = self.selectedReviewInProgressItem()
        let signOutButtonTouched = self.signOutButtonTouched()
        
        let input = YoutuberHomeViewModel.Input(
            viewWillAppear: viewWillAppear,
            selectedFinishedReviewItem: selectedFinishedReviewItem,
            selectedReviewInProgressItem: selectedReviewInProgressItem,
            signOutButtonTouched: signOutButtonTouched
        )
        let output = viewModel.transform(input: input)
        
        self.bindName(output.name)
        self.bindFinishedReviews(output.finishedReviews)
        self.bindReviewsInProgress(output.reviewsInProgress)
        self.bindSelectedFinishedReviewId(output.selectedFinishedReviewId)
        self.bindSelectedInProgressReviewId(output.selectedInProgressReviewId)
        self.bindDidSignOut(output.didSignOut)
    }
    
    // MARK: Input Event Creation
    
    private func viewWillAppearEvent() -> Driver<Bool> {
        return self.rx.viewWillAppear.asDriver()
    }
    
    private func selectedFinishedReviewItem() -> Driver<IndexPath> {
        guard let finishedReviewsTableViewController = self.finishedReviewsTableViewController else { return .never() }
        return finishedReviewsTableViewController.rx.itemSelected
            .asDriver()
    }
    
    private func selectedReviewInProgressItem() -> Driver<IndexPath> {
        guard let reviewsInProgressTableViewController = self.reviewsInProgressTableViewController else { return .never() }
        return reviewsInProgressTableViewController.rx.itemSelected
            .asDriver()
    }
    
    private func signOutButtonTouched() -> Driver<Void> {
        return self.signOutConfirmButtonTouched.asDriverIgnoringError()
    }
    
    // MARK: Output Binding
    
    private func bindName(_ name: Driver<String>) {
        name
            .drive(self.nameLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
    
    private func bindFinishedReviews(_ reviews: Driver<[YoutuberFinishedVideoCardItemViewModel]>) {
        guard let finishedReviewsTableViewController = self.finishedReviewsTableViewController else { return }
        
        reviews
            .drive(finishedReviewsTableViewController.rx.viewModels)
            .disposed(by: self.disposeBag)
    }
    
    private func bindReviewsInProgress(_ reviews: Driver<[YoutuberInProgressVideoCardItemViewModel]>) {
        guard let reviewsInProgressTableViewController = self.reviewsInProgressTableViewController else { return }
        
        reviews
            .drive(reviewsInProgressTableViewController.rx.viewModels)
            .disposed(by: self.disposeBag)
    }
    
    private func bindSelectedFinishedReviewId(_ id: Driver<Int>) {
        id
            .drive(with: self) { obj, id in
                obj.pushResultMenu(videoId: id)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindSelectedInProgressReviewId(_ id: Driver<Int>) {
        id
            .drive(with: self) { obj, id in
                obj.pushYoutuberVideoDetail(videoId: id)
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

// MARK: - Alerts

// TODO: AlertDisplaying 채택 코드 여기로 이동
extension YoutuberHomeViewController {
    private func displayConfirmSignOutAlert() {
        self.displayAlertWithAction(title: "로그아웃",
                                    message: "로그아웃 하시겠습니까?") { [weak self] _ in
            self?.signOutConfirmButtonTouched.accept(())
        }
    }
}
