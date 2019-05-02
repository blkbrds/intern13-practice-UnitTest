//
//  HomeCellViewModel.swift
//  TreeView
//
//  Created by MBA0023 on 4/15/19.
//  Copyright © 2019 MBA0023. All rights reserved.
//

import Foundation

final class HomeCellViewModel {
    
    var data: DataManager?
    var indexPath: IndexPath
    var numberOfChildren = 0
    var name: String? {
        return data?.name
    }
    var level: Int? {
        return data?.level
    }
    var check: Bool? {
        return data?.check
    }
    
    init(data: DataManager, indexPath: IndexPath, numberOfChildren: Int) {
        self.data = data
        self.indexPath = indexPath
        self.numberOfChildren = numberOfChildren
    }
}
