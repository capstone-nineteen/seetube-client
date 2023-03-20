//
//  StartScreenReturnable.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/20.
//

import UIKit

protocol StartScreenReturnable: UIViewController {
    func returnToStartScreen()
}

extension StartScreenReturnable {
    func returnToStartScreen() {
        let startNavigationController = self.storyboard?.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = startNavigationController
    }
}
