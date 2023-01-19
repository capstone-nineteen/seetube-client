//
//  YoutuberHomeViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/19.
//

import UIKit

class YoutuberHomeViewController: UIViewController {
    @IBOutlet weak var finishedReviewsView: UIView!
    @IBOutlet weak var reviewsInProgressView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UnderlineSegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.changeToFinishedReviewsTab()
        case 1:
            self.changeToReviewsInProgressTab()
        default:
            return
        }
    }
    
    private func changeToFinishedReviewsTab() {
        self.finishedReviewsView.isHidden = false
        self.reviewsInProgressView.isHidden = true
    }
    
    private func changeToReviewsInProgressTab() {
        self.finishedReviewsView.isHidden = true
        self.reviewsInProgressView.isHidden = false
    }
}
