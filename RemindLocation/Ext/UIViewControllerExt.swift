//
//  UIViewControllerExt.swift
//  ViperSample
//
//  Created by MBA0010 on 5/6/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import UIKit

// MARK: Helper Extensions
extension UIViewController {
    func showAlert(withTitle title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
