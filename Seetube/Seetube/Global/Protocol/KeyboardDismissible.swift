//
//  KeyboardDismissible.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/01.
//

import UIKit

protocol KeyboardDismissible: UIViewController {
    var coverView: UIView { get }
    func enableKeyboardDismissing()
}

extension KeyboardDismissible {
    func enableKeyboardDismissing() {
        self.addObservers()
        self.addTapGestureToCoverView()
    }
    
    private func addTapGestureToCoverView() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.coverView.addGestureRecognizer(tap)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification,
                                               object: nil,
                                               queue: OperationQueue.main) { [weak self] notification in
            self?.keyboardDidShow(notification)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification,
                                               object: nil,
                                               queue: OperationQueue.main) { [weak self] notification in
            self?.keyboardDidHide(notification)
        }
    }
    
    private func keyboardDidShow(_ sender: Notification) {
        self.view.addSubview(self.coverView)
        self.coverView.frame = self.view.bounds
    }
    
    private func keyboardDidHide(_ sender: Notification) {
        self.coverView.removeFromSuperview()
    }
}
