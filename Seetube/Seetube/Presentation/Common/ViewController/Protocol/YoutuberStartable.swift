//
//  YoutuberStartable.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/01.
//

import UIKit

protocol YoutuberStartable: UIViewController {
    func startAsYoutuber()
}

extension YoutuberStartable {
    func startAsYoutuber() {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "YoutuberNavigationController") as? UINavigationController else { return }
        
        UIApplication.shared.keyWindow?.rootViewController = viewController
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
}
