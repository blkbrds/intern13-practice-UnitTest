//
//  DataObject.swift
//  TreeView
//
//  Created by MBA0265P on 5/2/19.
//  Copyright © 2019 MBA0265P. All rights reserved.
//

import Foundation

final class DataObject {
    
    var isExpanded: Bool
    var name: String
    var level: Int
    var children: [DataObject]
    
    init(isExpanded: Bool, name: String, level: Int, children: [DataObject]) {
        self.isExpanded = isExpanded
        self.name = name
        self.level = level
        self.children = children
    }
}
