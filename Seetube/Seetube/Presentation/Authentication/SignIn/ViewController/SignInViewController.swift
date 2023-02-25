//
//  SignInViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/14.
//

import UIKit

class SignInViewController: UIViewController, ViewControllerPresentable {
    @IBOutlet weak var idTextField: UnderLineTextField!
    @IBOutlet weak var pwTextField: UnderLineTextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: BottomButton!
    
    var viewModel: SignInViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
