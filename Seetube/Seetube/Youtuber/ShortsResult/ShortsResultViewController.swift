//
//  ShortsResultViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/14.
//

import UIKit

class ShortsResultViewController: UIViewController {
    private lazy var rightBarButtonItem: UIBarButtonItem = {
       let item = UIBarButtonItem(title: "선택",
                                  style: .plain,
                                  target: self,
                                  action: #selector(changeToSelectionMode(_:)))
        return item
    }()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var saveButton: BottomButton!
    @IBOutlet weak var collectionViewBottomConstraint: NSLayoutConstraint!
    private let collectionViewItemSpacing: CGFloat = 5
    private let collectionViewHorizontalInset: CGFloat = 17
    private let collectionViewVerticalInset: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureRightBarButtonItem()
        self.changeToNormalMode()
    }
    
    @IBAction func saveButtonTouched(_ sender: Any) {
        // 저장
        self.changeToNormalMode()
        // TODO: 얼럿
    }
}

extension ShortsResultViewController {
    private func configureRightBarButtonItem() {
        self.navigationItem.setRightBarButton(self.rightBarButtonItem, animated: true)
    }
}

extension ShortsResultViewController {
    @objc private func changeToSelectionMode(_ sender: Any) {
        self.rightBarButtonItem.isHidden = true
        self.saveButton.isHidden = false
        self.collectionViewBottomConstraint.constant = 50 + 7 + 5
        self.collectionView.allowsSelection = true
        self.collectionView.allowsMultipleSelection = true
    }
    
    private func changeToNormalMode() {
        self.rightBarButtonItem.isHidden = false
        self.saveButton.isHidden = true
        self.collectionViewBottomConstraint.constant = 0
        self.collectionView.allowsSelection = false
    }
}

extension ShortsResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 셀 선택
    }
}

extension ShortsResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShortsCollectionViewCell", for: indexPath)
        return cell
        // TODO: 커스텀 cell 클래스 작성 후 as?로 캐스팅 추가
    }
}

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