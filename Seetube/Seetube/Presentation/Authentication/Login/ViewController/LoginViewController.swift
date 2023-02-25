//
//  LoginViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/14.
//

import UIKit

class LoginViewController: UIViewController, ViewControllerPresentable {
    @IBOutlet weak var idTextField: UnderLineTextField!
    @IBOutlet weak var pwTextField: UnderLineTextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: BottomButton!
    
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
