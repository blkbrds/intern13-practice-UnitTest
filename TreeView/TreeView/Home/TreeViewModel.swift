//
//  TreeViewModel.swift
//  TreeView
//
//  Created by MBA0265P on 5/2/19.
//  Copyright © 2019 MBA0265P. All rights reserved.
//

import Foundation

final class TreeViewModel {
    
    // MARK: - Properties
    var dataObjects: [DataObject] = []
    
    // MARK: - Table view
    func numberOfRow(in section: Int) -> Int {
        return dataObjects.count
    }
    
    func viewModelForItem(at indexPath: IndexPath) -> TreeCellModel {
        let dataObject = dataObjects[indexPath.row]
        return TreeCellModel(dataObject: dataObject, indexPath: indexPath)
    }
    
    func getData() {
        dataObjects = DataManager.DummyData()
    }
    
    func addNewObject(at indexPath: IndexPath) {
        var level = 0
        if dataObjects[indexPath.row].level == 0 {
            level = 1
        } else if dataObjects[indexPath.row].level == 1 {
            level = 2
        } else {
            return
        }
        let newObject = DataObject(isExpanded: false, name: "New Object", level: level, children: [])
        dataObjects[indexPath.row].children.insert(newObject, at: 0)
        dataObjects.insert(newObject, at: indexPath.row + 1)
    }
}

