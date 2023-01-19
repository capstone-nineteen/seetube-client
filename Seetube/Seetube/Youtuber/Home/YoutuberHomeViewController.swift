//
//  YoutuberHomeViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/19.
//

import UIKit

class YoutuberHomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}
