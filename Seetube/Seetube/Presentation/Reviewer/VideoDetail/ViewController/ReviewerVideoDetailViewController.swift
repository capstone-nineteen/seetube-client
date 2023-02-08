//
//  VideoDetailViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit

class ReviewerVideoDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}
