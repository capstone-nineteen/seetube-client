//
//  ShortsResultViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/14.
//

import UIKit
import RxCocoa
import RxSwift

class ShortsResultViewController: UIViewController, AlertDisplaying {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var saveButton: BottomButton!
    @IBOutlet weak var collectionViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    
    private let collectionViewItemSpacing: CGFloat = 5
    private let collectionViewHorizontalInset: CGFloat = 17
    private let collectionViewVerticalInset: CGFloat = 5
    
    var viewModel: ShortsResultViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
    }
}

// MARK: - Configuration

extension ShortsResultViewController {
    private func configureUI() {
        self.configureRightBarButtonItem()
    }
    
    private func configureRightBarButtonItem() {
        self.changeToNormalMode()
        self.collectionView.allowsSelection = true
        
        self.rightBarButtonItem.rx.tap
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.changeToSelectionMode()
            }
            .disposed(by: self.disposeBag)
    }
    
    private func changeToSelectionMode() {
        self.navigationItem.setRightBarButton(nil, animated: false)
        self.saveButton.isHidden = false
        self.collectionView.allowsMultipleSelection = true
        self.collectionViewBottomConstraint.constant = 50 + 7 + 5
        self.collectionView.reloadData()
    }
    
    private func changeToNormalMode() {
        self.navigationItem.setRightBarButton(self.rightBarButtonItem, animated: false)
        self.saveButton.isHidden = true
        self.collectionView.allowsMultipleSelection = false
        self.collectionViewBottomConstraint.constant = 0
        self.collectionView.reloadData()
    }
}

// MARK: - ViewModel Binding

extension ShortsResultViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let viewWillAppear = self.viewWillAppearEvent()
        let itemSelected = self.itemSelectedEvent()
        let selectedButtonTouched = self.selectedButtonTouched()
        let saveButtonTouched = self.saveButtonTouched()
        
        let input = ShortsResultViewModel.Input(
            viewWillAppear: viewWillAppear,
            itemSelected: itemSelected,
            selectedButtonTouched: selectedButtonTouched,
            saveButtonTouched: saveButtonTouched
        )
        let output = viewModel.transform(input: input)
        
        self.bindShorts(output.shorts)
        self.bindShouldPlay(output.shouldPlay)
        self.bindSaveResult(output.saveResult)
    }
    
    // MARK: Input Event Creation
    
    private func viewWillAppearEvent() -> Driver<Bool> {
        return self.rx.viewWillAppear.asDriver()
    }
    
    private func itemSelectedEvent() -> Driver<IndexPath> {
        return self.collectionView.rx.itemSelected.asDriver()
    }
    
    private func selectedButtonTouched() -> Driver<Void> {
        return self.rightBarButtonItem.rx.tap.asDriver()
    }
    
    private func saveButtonTouched() -> Driver<Void> {
        return self.saveButton.rx.tap.asDriver()
    }
    
    // MARK: Output Binding
    
    private func bindShorts(_ shorts: Driver<[ShortsItemViewModel]>) {
        shorts
            .drive(
                self.collectionView.rx.items(
                    cellIdentifier: ShortsCollectionViewCell.cellReuseIdentifier,
                    cellType: ShortsCollectionViewCell.self)
            ) { row, viewModel, cell in
                cell.bind(viewModel)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindShouldPlay(_ shouldPlay: Driver<IndexPath?>) {
        shouldPlay
            .drive(with: self) { _ in
                // TODO: 영상 재생
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindSaveResult(_ saveResult: Driver<Bool>) {
        saveResult
            .drive(with: self) { obj, isSucceed in
                if isSucceed {
                    obj.displaySaveSucceedAlert()
                } else {
                    obj.displaySaveFailedAlert()
                }
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Alerts

extension ShortsResultViewController {
    private func displaySaveSucceedAlert() {
        self.displayOKAlert(title: "저장 완료",
                            message: "쇼츠를 저장했습니다.",
                            action: { [weak self] _ in self?.changeToNormalMode() })
    }
    
    private func displaySaveFailedAlert() {
        self.displayFailureAlert(message: "저장에 실패했습니다. 다시 시도해주세요.")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ShortsResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.bounds.width - 2*self.collectionViewHorizontalInset - self.collectionViewItemSpacing) / 2
        let height: CGFloat = width / 9 * 16
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.collectionViewVerticalInset,
                            left: self.collectionViewHorizontalInset,
                            bottom: self.collectionViewVerticalInset,
                            right: self.collectionViewHorizontalInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.collectionViewItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.collectionViewItemSpacing
    }
}
