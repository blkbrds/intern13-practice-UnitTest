//
//  LoginPrsenter.swift
//  DemoViper
//
//  Created by Van Le H. on 3/28/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

protocol LoginEventHandler {
    func handleLoginAction(email: String, password: String)
}

final class DefaultLoginPresenter: LoginEventHandler {
    
    private weak var view: LoginView?
    private var router: LoginRouter?
    private var loginInteractor: LoginInteractor?
    
    init(view: LoginView?, router: LoginRouter?, loginInteractor: LoginInteractor?) {
        self.view = view
        self.router = router
        self.loginInteractor = loginInteractor
        self.loginInteractor?.output = self
    }
    
    private func showHomeScreen() {
        router?.showHomeScreen()
    }
    
    private func showError(error: Error) {
        router?.showError(error: error)
    }
    
    func handleLoginAction(email: String, password: String) {
        loginInteractor?.login(email: email, password: password)
    }
}

extension DefaultLoginPresenter: LoginInteractorOutput {
    func didLogin(result: Result<User>) {
        switch result {
        case .success(let user):
            print("Welcome \(user.name)")
            showHomeScreen()
        case .failure(let error):
            showError(error: error)
        }
    }
}
