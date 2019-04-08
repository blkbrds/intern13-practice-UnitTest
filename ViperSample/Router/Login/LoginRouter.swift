//
//  LoginRouter.swift
//  DemoViper
//
//  Created by Van Le H. on 3/28/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import UIKit

protocol LoginRouter {
    func showHomeScreen()
    func showError(error: Error)
}

final class DefaultLoginRouter: LoginRouter {
    
    weak var viewController: UIViewController?

    func showHomeScreen() {
        let target = homeViewController()
        viewController?.navigationController?.pushViewController(target, animated: true)
    }
    
    func showError(error: Error) {
        let alertVC = UIAlertController(title: nil,
                                        message: error.localizedDescription,
                                        preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(okAction)
        viewController?.present(alertVC, animated: true, completion: nil)

    }
    
    private func homeViewController() -> HomeViewController {
        let viewController = HomeViewController()
        let router = DefaultHomeRouter()
        router.viewController = viewController
        let listFruitInteractor = DefaultListFruitInteractor()
        let presenter = DefaultHomePresenter(view: viewController, router: router, fruitInteractor: listFruitInteractor)
        viewController.eventHandler = presenter
        return viewController
    }
}
