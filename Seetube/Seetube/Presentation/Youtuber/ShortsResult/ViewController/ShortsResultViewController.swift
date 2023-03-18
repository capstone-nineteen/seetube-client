//
//  ShortsResultViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/14.
//

import UIKit
import RxCocoa
import RxSwift
import AVFoundation

class ShortsResultViewController: UIViewController,
                                  AlertDisplaying
{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var saveButton: BottomButton!
    @IBOutlet weak var collectionViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var loadingView: UIView!
    
    private let collectionViewItemSpacing: CGFloat = 5
    private let collectionViewHorizontalInset: CGFloat = 17
    private let collectionViewVerticalInset: CGFloat = 5
    
    // Video Player
    private var player: AVPlayer?
    
    // ViewModel
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
        self.configureSaveButton()
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
    
    private func configureSaveButton() {
        self.saveButton.rx.tap
            .asDriver()
            .drive(with: self) { obj, _ in
                obj.loadingView.isHidden = false
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - ViewModel Binding

extension ShortsResultViewController {
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let viewWillAppear = self.viewWillAppearEvent()
        let itemSelected = self.itemSelectedEvent()
        let indexPathsForSelectedItems = self.indexPathsForSelectedItems()
        let selectedButtonTouched = self.selectedButtonTouched()
        let saveButtonTouched = self.saveButtonTouched()
        
        let input = ShortsResultViewModel.Input(
            viewWillAppear: viewWillAppear,
            itemSelected: itemSelected,
            indexPathsForSelectedItems: indexPathsForSelectedItems,
            selectedButtonTouched: selectedButtonTouched,
            saveButtonTouched: saveButtonTouched
        )
        let output = viewModel.transform(input: input)
        
        self.bindShorts(output.shorts)
        self.bindShouldPlay(output.shouldPlay)
        self.bindShouldPause(output.shouldPause)
        self.bindNumberOfSelectedShorts(output.numberOfSelectedShorts)
        self.bindSaveResult(output.saveResult)
        self.bindShouldRequestAuthorization(output.shouldRequestAuthorization)
    }
    
    // MARK: Input Event Creation
    
    private func viewWillAppearEvent() -> Driver<Bool> {
        return self.rx.viewWillAppear.asDriver()
    }
    
    private func itemSelectedEvent() -> Driver<IndexPath> {
        return self.collectionView.rx.itemSelected.asDriver()
    }
    
    private func indexPathsForSelectedItems() -> Driver<[IndexPath]> {
        return Driver
            .merge(
                self.collectionView.rx.itemSelected.asDriver(),
                self.collectionView.rx.itemDeselected.asDriver()
            )
            .map { [weak self] _ in
                guard let self = self else { return nil }
                return self.collectionView.indexPathsForSelectedItems
            }
            .map { $0 ?? [] }
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
                
                if viewModel.isPlaying {
                    guard let player = self.player else { return }
                    cell.addPlayerLayer(player: player)
                } else {
                    cell.removePlayerLayer()
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindShouldPlay(_ shouldPlay: Driver<(url: URL?, indexPath: IndexPath)>) {
        shouldPlay
            .drive(with: self) { obj, shouldPlay in
                obj.playVideo(url: shouldPlay.url,
                              at: shouldPlay.indexPath)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindShouldPause(_ shouldPause: Driver<IndexPath>) {
        shouldPause
            .drive(with: self) { obj, indexPath in
                obj.pauseVideo(at: indexPath)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindNumberOfSelectedShorts(_ numberOfSelectedShorts: Driver<Int>) {
        numberOfSelectedShorts
            .map { "\($0)개의 쇼츠 저장하기"}
            .drive(self.saveButton.rx.text)
            .disposed(by: self.disposeBag)
        
        numberOfSelectedShorts
            .map { $0 > 0 }
            .drive(self.saveButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
    }
    
    private func bindSaveResult(_ saveResult: Driver<Bool>) {
        saveResult
            .drive(with: self) { obj, isSucceed in
                obj.loadingView.isHidden = true
                
                if isSucceed {
                    obj.displaySaveSucceedAlert()
                } else {
                    obj.displaySaveFailedAlert()
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    private func bindShouldRequestAuthorization(_ shouldRequestAuthorization: Driver<Void>) {
        shouldRequestAuthorization
            .drive(with: self) { obj, _ in
                obj.displayAuthorizationNeededAlert()
            }
            .disposed(by: self.disposeBag)
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

// MARK: - Video Playing

extension ShortsResultViewController {
    private func playVideo(url: URL?, at indexPath: IndexPath) {
        guard let url = url else { return }
        
        if self.player == nil {
            self.player = AVPlayer(url: url)
        } else {
            let playerItem = AVPlayerItem(url: url)
            self.player?.replaceCurrentItem(with: playerItem)
        }
        
        self.collectionView.reloadItems(at: [indexPath])
        self.player?.play()
    }
    
    private func pauseVideo(at indexPath: IndexPath) {
        self.player?.pause()
        self.collectionView.reloadItems(at: [indexPath])
    }
}

// MARK: - Modes

extension ShortsResultViewController {
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
    
    private func displayAuthorizationNeededAlert() {
        self.displayOpenSettingsAlert(title: "권한 필요",
                                      message: "사진앱에 저장하기 위해서는 접근 권한이 필요합니다.")
    }
}
