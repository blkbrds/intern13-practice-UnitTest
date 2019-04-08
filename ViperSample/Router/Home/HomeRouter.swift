//
//  HomeRouter.swift
//  DemoViper
//
//  Created by Van Le H. on 3/29/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import UIKit

import UIKit

protocol HomeRouter {
    func showError(error: Error)
}

final class DefaultHomeRouter: HomeRouter {

    weak var viewController: UIViewController?
    
    // MARK: - HomeRouter implementation
    func showError(error: Error) {
        let alertVC = UIAlertController(title: nil,
                                        message: error.localizedDescription,
                                        preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(okAction)
        viewController?.present(alertVC, animated: true, completion: nil)
    }
}
