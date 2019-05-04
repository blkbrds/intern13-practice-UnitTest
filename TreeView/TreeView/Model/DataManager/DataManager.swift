//
//  DataManager.swift
//  TreeView
//
//  Created by MBA0265P on 5/2/19.
//  Copyright © 2019 MBA0265P. All rights reserved.
//

import Foundation

final class DataManager {
    
    static func DummyData() -> [DataObject] {
        let iPhone1 = DataObject(isExpanded: false, name: "iPhone 1", level: 2, children: [])
        let iPhone2 = DataObject(isExpanded: false, name: "iPhone 2", level: 2, children: [])
        let iPhone3 = DataObject(isExpanded: false, name: "iPhone 3", level: 2, children: [])
        let iPhones = DataObject(isExpanded: false, name: "iPhones", level: 1, children: [iPhone1, iPhone2, iPhone3])
        
        let samsungs = DataObject(isExpanded: false, name: "Samsung", level: 1, children: [])
        let xiaomis = DataObject(isExpanded: false, name: "Xiaomi", level: 1, children: [])
        
        let phones = DataObject(isExpanded: false, name: "Phones", level: 0, children: [iPhones, samsungs, xiaomis])
        
        let dell1 = DataObject(isExpanded: false, name: "Dell 1", level: 2, children: [])
        let dell2 = DataObject(isExpanded: false, name: "Dell 2", level: 2, children: [])
        let dell3 = DataObject(isExpanded: false, name: "Dell 3", level: 2, children: [])
        let dell = DataObject(isExpanded: false, name: "Dell", level: 1, children: [dell1, dell2, dell3])
        
        let asus = DataObject(isExpanded: false, name: "Asus", level: 1, children: [])
        
        let macbook1 = DataObject(isExpanded: false, name: "Macbook 1", level: 2, children: [])
        let macbook2 = DataObject(isExpanded: false, name: "Macbook 2", level: 2, children: [])
        let macbook = DataObject(isExpanded: false, name: "Macbook", level: 1, children: [macbook1, macbook2])
        
        let vaio = DataObject(isExpanded: false, name: "Vaio", level: 1, children: [])
        
        let computers = DataObject(isExpanded: false, name: "Computers", level: 0, children: [dell, asus, macbook, vaio])

        let cars = DataObject(isExpanded: false, name: "Cars", level: 0, children: [])
        let fruits = DataObject(isExpanded: false, name: "Fruits", level: 0, children: [])
        
        return [phones, computers, cars, fruits]
    }
}
