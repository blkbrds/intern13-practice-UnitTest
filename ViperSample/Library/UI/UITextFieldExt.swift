//
//  UITextFieldExt.swift
//  DemoViper
//
//  Created by Van Le H. on 3/28/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import UIKit

extension UITextField {
    var value: String {
        guard let text = text else { return "" }
        return text
    }
}
