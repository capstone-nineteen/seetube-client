//
//  ViewControllerPresentable.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/31.
//

import UIKit

protocol ViewControllerPresentable: UIViewController {
    func present<T: UIViewController>(viewControllerType: T.Type,
                                      modalPresentationStyle: UIModalPresentationStyle,
                                      animated: Bool,
                                      setUp: ((T)->Void)?,
                                      completion: (() -> Void)?)
    func present<T: UIViewController>(viewControllerIdentifier: String,
                                      modalPresentationStyle: UIModalPresentationStyle,
                                      animated: Bool,
                                      setUp: ((T)->Void)?,
                                      completion: (() -> Void)?)
}

extension ViewControllerPresentable {
    func present<T: UIViewController>(viewControllerType: T.Type,
                                      modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
                                      animated: Bool = false,
                                      setUp: ((T)->Void)? = nil,
                                      completion: (() -> Void)? = nil
    ) {
        self.present(viewControllerIdentifier: String(describing: viewControllerType),
                     modalPresentationStyle: modalPresentationStyle,
                     animated: animated,
                     setUp: setUp,
                     completion: completion)
    }
    
    func present<T: UIViewController>(viewControllerIdentifier: String,
                                      modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
                                      animated: Bool = false,
                                      setUp: ((T)->Void)? = nil,
                                      completion: (() -> Void)? = nil
    ) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: viewControllerIdentifier) as? T else { return }
        setUp?(viewController)
        viewController.modalPresentationStyle = modalPresentationStyle
        self.present(viewController, animated: animated, completion: completion)
    }
}
