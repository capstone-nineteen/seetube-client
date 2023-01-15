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
        self.configureSegmentedControl()
        self.changeToReviewerMode()
    }

    @IBAction func googleSignInButtonTouched(_ sender: UIButton) {
        // 구글 로그인
        print("DEBUG: google sign in button touched")
    }
    
    @IBAction func appleSignInButtonTouched(_ sender: UIButton) {
        // 애플 로그인
        print("DEBUG: apple sign in button touched")
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
    private func configureSegmentedControl() {
        let backgroundImage = UIImage()
        //self.segmentedControl.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.segmentedControl.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
        self.segmentedControl.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemGray, .font: UIFont.systemFont(ofSize: 14)], for: .normal)
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "AccentColor") ?? UIColor.systemPink, .font: UIFont.systemFont(ofSize: 15, weight: .semibold)], for: .selected)
    }
}

extension LoginViewController {
    private func changeToReviewerMode() {
        self.guidanceLabel.text = "원하는 컨텐츠를 시청하고\n리워드를 적립해보세요"
    }
    
    private func changeToYoutuberMode() {
        self.guidanceLabel.text = "내 유튜브 동영상에"
    }
}
