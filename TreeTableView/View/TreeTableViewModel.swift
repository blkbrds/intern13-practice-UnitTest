//
//  TreeTableViewModel.swift
//  TreeTableView
//
//  Created by MBA0010 on 5/2/19.
//  Copyright © 2019 MBA0010. All rights reserved.
//

import Foundation
import MVVM

final class TreeTableViewModel: ViewModel {
    
    var datas: [Tree] = []
    
    init() {
        datas = Dummy.datas
    }
    
    func numberOfSections() -> Int {
        return datas.count
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        if !datas[section].isOpen {
            return 1
        }
        return 2
    }
    
    func viewModelForItem(at indexPath: IndexPath) -> ViewModel {
        if indexPath.row == 0 {
            let tree = datas[indexPath.section]
            let vm = TableCellViewModel(tree: tree, type: .lv1)
            return vm
        }
        
        let child = datas[indexPath.section].child
        let vm = ExpandCollapsCellViewModel(trees: child)
        return vm
    }
}

extension TreeTableViewModel {
    
    struct Dummy {
        static let datas: [Tree] = {
            let data1 = Tree(title: "Computer", child: [Tree(title: "Computer 1", child: [Tree(title: "Computer 1, type 1", child: [], isOpen: false),
                                                                                          Tree(title: "Computer 1, type 2", child: [], isOpen: false),
                                                                                          Tree(title: "Computer 1, type 3", child: [], isOpen: false),
                                                                                          Tree(title: "Computer 1, type 4", child: [], isOpen: false),], isOpen: false),
                                                        Tree(title: "Computer 2", child: [Tree(title: "Computer 2, type 1", child: [], isOpen: false),
                                                                                          Tree(title: "Computer 2, type 2", child: [], isOpen: false),
                                                                                          Tree(title: "Computer 2, type 3", child: [], isOpen: false),
                                                                                          Tree(title: "Computer 2, type 4", child: [], isOpen: false),], isOpen: false),
                                                        Tree(title: "Computer 3", child: [Tree(title: "Computer 3, type 1", child: [], isOpen: false),
                                                                                          Tree(title: "Computer 3, type 2", child: [], isOpen: false),
                                                                                          Tree(title: "Computer 3, type 3", child: [], isOpen: false),], isOpen: false)
                ], isOpen: false)
            
            let data2 = Tree(title: "Printer", child: [Tree(title: "Printer 1", child: [Tree(title: "Printer 1, type 1", child: [], isOpen: false),
                                                                                          Tree(title: "Printer 1, type 2", child: [], isOpen: false),
                                                                                          Tree(title: "Printer 1, type 3", child: [], isOpen: false),
                                                                                          Tree(title: "Printer 1, type 4", child: [], isOpen: false),], isOpen: false),
                                                        Tree(title: "Printer 2", child: [Tree(title: "Printer 2, type 1", child: [], isOpen: false),
                                                                                          Tree(title: "Printer 2, type 2", child: [], isOpen: false),
                                                                                          Tree(title: "Printer 2, type 3", child: [], isOpen: false),
                                                                                          Tree(title: "Printer 2, type 4", child: [], isOpen: false),], isOpen: false),
                                                        Tree(title: "Printer 3", child: [Tree(title: "Printer 3, type 1", child: [], isOpen: false),
                                                                                          Tree(title: "Printer 3, type 2", child: [], isOpen: false),
                                                                                          Tree(title: "Printer 3, type 3", child: [], isOpen: false),], isOpen: false)
                ], isOpen: false)
            
            let data3 = Tree(title: "Phone", child: [Tree(title: "Phone 1", child: [Tree(title: "Phone 1, type 1", child: [], isOpen: false),
                                                                                          Tree(title: "Phone 1, type 2", child: [], isOpen: false),
                                                                                          Tree(title: "Phone 1, type 3", child: [], isOpen: false),
                                                                                          Tree(title: "Phone 1, type 4", child: [], isOpen: false),], isOpen: false),
                                                        Tree(title: "Phone 2", child: [Tree(title: "Phone 2, type 1", child: [], isOpen: false),
                                                                                          Tree(title: "Phone 2, type 2", child: [], isOpen: false),
                                                                                          Tree(title: "Phone 2, type 3", child: [], isOpen: false),
                                                                                          Tree(title: "Phone 2, type 4", child: [], isOpen: false),], isOpen: false),
                                                        Tree(title: "Phone 3", child: [Tree(title: "Phone 3, type 1", child: [], isOpen: false),
                                                                                          Tree(title: "Phone 3, type 2", child: [], isOpen: false),
                                                                                          Tree(title: "Phone 3, type 3", child: [], isOpen: false),], isOpen: false)
                ], isOpen: false)
            
            return [data1, data2, data3]
        }()
    }
}
