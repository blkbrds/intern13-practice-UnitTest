//
//  LoginViewController.swift
//  DemoViper
//
//  Created by Van Le H. on 3/28/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import UIKit

protocol LoginView: class {
    var eventHandler: LoginEventHandler? { get set }
}

final class LoginViewController: UIViewController, LoginView {

    var eventHandler: LoginEventHandler?
    
    // MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
    }

    @IBAction func loginButtonTouchUpInside(_ sender: Any) {
        eventHandler?.handleLoginAction(email: emailTextField.value, password: passwordTextField.value)
    }
}
