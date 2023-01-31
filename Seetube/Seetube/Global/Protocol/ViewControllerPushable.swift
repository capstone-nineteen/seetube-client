//
//  ViewControllerPushable.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/31.
//

import UIKit

protocol ViewControllerPushable: UIViewController {
    func push<T: UIViewController>(viewControllerType: T.Type,
                                   animated: Bool,
                                   setUp: ((T)->Void)?)
    func push<T: UIViewController>(viewControllerIdentifier: String,
                                   animated: Bool,
                                   setUp: ((T)->Void)?)
}

extension ViewControllerPushable {
    func push<T: UIViewController>(viewControllerType: T.Type,
                                   animated: Bool = true,
                                   setUp: ((T)->Void)? = nil
    ) {
        self.push(viewControllerIdentifier: String(describing: viewControllerType),
                  animated: animated,
                  setUp: setUp)
    }
    
    func push<T: UIViewController>(viewControllerIdentifier: String,
                                   animated: Bool = true,
                                   setUp: ((T)->Void)? = nil
    ) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: viewControllerIdentifier) as? T else { return }
        setUp?(viewController)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
