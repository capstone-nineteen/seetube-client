//
//  LoginViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/14.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var guidanceLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeToReviewerMode()
    }

    @IBAction func googleSignInButtonTouched(_ sender: UIButton) {
        // 구글 로그인
        print("DEBUG: google sign in button touched")
        self.start()
    }
    
    @IBAction func appleSignInButtonTouched(_ sender: UIButton) {
        // 애플 로그인
        print("DEBUG: apple sign in button touched")
        self.start()
    }
    
    @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.changeToReviewerMode()
        case 1:
            self.changeToYoutuberMode()
        default:
            return
        }
    }
}

extension LoginViewController {
    private func start() {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            self.startAsReviewer()
        case 1:
            self.startAsYoutuber()
        default:
            return
        }
    }
    
    private func startAsReviewer() {
        guard let reviewerTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "ReviewerTabBarController") else { return }
        reviewerTabBarController.modalPresentationStyle = .fullScreen
        self.present(reviewerTabBarController, animated: false)
    }
    
    private func startAsYoutuber() {
        guard let youtuberNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "YoutuberNavigationController") else { return }
        youtuberNavigationController.modalPresentationStyle = .fullScreen
        self.present(youtuberNavigationController, animated: false)
    }
}


extension LoginViewController {
    private func changeToReviewerMode() {
        self.guidanceLabel.text = "원하는 컨텐츠를 시청하고\n리워드를 적립해보세요"
    }
    
    private func changeToYoutuberMode() {
        self.guidanceLabel.text = "내 유튜브 동영상에 대한\n사람들의 반응을 확인해보세요"
    }
}
