//
//  Tree.swift
//  TreeTableView
//
//  Created by MBA0010 on 5/2/19.
//  Copyright © 2019 MBA0010. All rights reserved.
//

import Foundation

final class Tree {
    
    var title = ""
    var child: [Tree] = []
    var isOpen = false
    
    init() {
    }
    
    init(title: String, child: [Tree], isOpen: Bool = false) {
        self.title = title
        self.child = child
        self.isOpen = isOpen
    }
}
