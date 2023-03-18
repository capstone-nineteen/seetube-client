//
//  AlertDisplaying.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/14.
//

import UIKit

typealias AlertAction = (UIAlertAction) -> Void

protocol AlertDisplaying: UIViewController {
    func displayOKAlert(title: String?, message: String?, action: AlertAction?)
    func displayFailureAlert(message: String?, action: AlertAction?)
    func displayOpenSettingsAlert(title: String?, message: String?)
    func displayAlertWithAction(title: String?, message: String?, action: AlertAction?)
}

extension AlertDisplaying {
    func displayOKAlert(
        title: String?,
        message: String?,
        action: AlertAction? = nil
    ) {
        displayAlert(title: title,
                     message: message,
                     actions: [UIAlertAction(title: "확인", style: .default, handler: action)])
    }
    
    func displayFailureAlert(
        message: String? = "문제가 발생했습니다.",
        action: AlertAction? = nil
    ) {
        displayAlert(title: "에러",
                     message: message,
                     actions: [UIAlertAction(title: "취소", style: .destructive, handler: action)])
    }
    
    func displayOpenSettingsAlert(
        title: String?,
        message: String?
    ) {
        let settingsAction: AlertAction = { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            }
        }
        
        displayAlertWithAction(title: title,
                               message: message,
                               action: settingsAction)
    }
    
    func displayAlertWithAction(
        title: String?,
        message: String?,
        action: AlertAction?
    ) {
        displayAlert(title: title,
                     message: message,
                     actions: [UIAlertAction(title: "확인", style: .default, handler: action),
                               UIAlertAction(title: "취소", style: .cancel, handler: nil)])
    }
    
    private func displayAlert(
        title: String? = "",
        message: String? = "",
        actions: [UIAlertAction] = []
    ) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        actions.forEach { alertController.addAction($0) }
        present(alertController, animated: true, completion: nil)
    }
}
