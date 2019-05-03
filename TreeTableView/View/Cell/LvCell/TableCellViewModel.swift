//
//  TableCellViewModel.swift
//  TreeTableView
//
//  Created by MBA0010 on 5/2/19.
//  Copyright © 2019 MBA0010. All rights reserved.
//

import Foundation
import MVVM

final class TableCellViewModel: ViewModel {
    
    var title = ""
    var subtitle = ""
    var isOpen = false
    var type: TypeCell = .lv1
    
    init() { }
    
    init(tree: Tree, type: TypeCell) {
        title = tree.title
        subtitle = "Number Of Children \(tree.child.count)"
        isOpen = tree.isOpen
        self.type = type
    }
}

extension TableCellViewModel {
    
    enum TypeCell {
        case lv1
        case lv2
        case lv3
    }
}
