//
//  ReviewerStartable.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/01.
//

import UIKit

protocol ReviewerStartable: UIViewController {
    func startAsReviewer()
}

extension ReviewerStartable {
    func startAsReviewer() {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ReviewerTabBarController") as? ReviewerTabBarController else { return }
        UIApplication.shared.keyWindow?.rootViewController = viewController
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
}
