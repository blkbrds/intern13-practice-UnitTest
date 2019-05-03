//
//  ExpandCollapsCellViewModel.swift
//  TreeTableView
//
//  Created by MBA0010 on 5/2/19.
//  Copyright © 2019 MBA0010. All rights reserved.
//

import Foundation
import MVVM

final class ExpandCollapsCellViewModel: ViewModel {
    
    var datas: [Tree] = []
    
    init(trees: [Tree] = []) {
        self.datas = trees
    }
    
    func numberOfSections() -> Int {
        return datas.count
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        if !datas[section].isOpen {
            return 1
        }
        return datas[section].child.count + 1
    }
    
    func viewModelForItem(at indexPath: IndexPath) -> ViewModel {
        if indexPath.row == 0 {
            let tree = datas[indexPath.section]
            let vm = TableCellViewModel(tree: tree, type: .lv2)
            return vm
        }
        
        let tree = datas[indexPath.section].child[indexPath.row - 1]
        let vm = TableCellViewModel(tree: tree, type: .lv3)
        return vm
    }
}
