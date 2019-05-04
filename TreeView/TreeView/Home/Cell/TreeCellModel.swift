//
//  TreeCellModel.swift
//  TreeView
//
//  Created by MBA0265P on 5/2/19.
//  Copyright © 2019 MBA0265P. All rights reserved.
//

import Foundation

final class TreeCellModel {
    
    // MARK: - Properties
    var indexPath: IndexPath?
    var name: String
    var level: Int
    var children: [DataObject]
    
    init(dataObject: DataObject, indexPath: IndexPath) {
        self.indexPath = indexPath
        name = dataObject.name
        level = dataObject.level
        children = dataObject.children
    }
}
