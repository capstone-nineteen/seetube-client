//
//  YoutuberVideoDetailViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/27.
//

import UIKit

class YoutuberVideoDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
