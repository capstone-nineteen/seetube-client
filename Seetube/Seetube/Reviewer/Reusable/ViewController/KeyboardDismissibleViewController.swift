//
//  KeyboardDismissibleViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/28.
//

import UIKit

class KeyboardDismissibleViewController: UIViewController {
    private lazy var coverView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCoverView()
    }
    
    private func configureCoverView() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.coverView.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc private func keyboardDidShow(_ sender: Notification) {
        self.view.addSubview(self.coverView)
        self.coverView.frame = self.view.bounds
    }
    
    @objc private func keyboardDidHide(_ sender: Notification) {
        self.coverView.removeFromSuperview()
    }
}
