//
//  DataManager.swift
//  TreeView
//
//  Created by MBA0023 on 4/15/19.
//  Copyright © 2019 MBA0023. All rights reserved.
//

import Foundation

final class DataManager {
    var name = ""
    var child: [DataManager] = []
    var isExplain = true
    var level = 0
    
    init() { }
    
    init(name: String, child: [DataManager], level: Int) {
        self.name = name
        self.child = child
        self.level = level
    }
    
    convenience init(name: String, level: Int) {
        self.init(name: name, child: [DataManager](), level: level)
    }
}

extension DataManager {
    
    struct Dummy {
        static let datas: [DataManager] = {
            let phone1 = DataManager(name: "Phone 1", level: 2)
            let phone2 = DataManager(name: "Phone 2", level: 2)
            let phone3 = DataManager(name: "Phone 3", level: 2)
            let phones = DataManager(name: "Phone", child: [phone1, phone2, phone3], level: 1)
            
            let dell = DataManager(name: "Dell", level: 3)
            let macbook = DataManager(name: "MacBook", level: 3)
            let asus = DataManager(name: "Asus", level: 3)
            let computer1 = DataManager(name: "Computer1", child: [dell, macbook, asus], level: 2)
            let computer2 = DataManager(name: "Computer 2", child: [dell], level: 2)
            let computer3 = DataManager(name: "Computer 3", child: [], level: 2)
            let computers = DataManager(name: "Computers", child: [computer1, computer2, computer3], level: 1)
            
            return [phones, computers]
        }()
    }
}
