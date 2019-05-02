//
//  HomeViewModel.swift
//  TreeView
//
//  Created by MBA0023 on 4/15/19.
//  Copyright © 2019 MBA0023. All rights reserved.
//

import Foundation

final class HomeViewModel {
    
    var datas = DataManager.Dummy.datas
    
    func numberOfItem() -> Int {
        return datas.count
    }
    
    func addRow(atIndexPath indexPath: IndexPath) {
        let arr = datas[indexPath.row].child
        for i in 0..<arr.count {
            datas.insert(arr[i], at: indexPath.row + i + 1)
        }
    }
    
    func removeRow(at indexPath: IndexPath, num: Int) {
        for _ in 0..<num {
            datas.remove(at: indexPath.row + 1)
        }
    }

    func numberOfItemNeedDelete(at indexPath: IndexPath) -> Int {
        var count = 0
        if datas[indexPath.row].level == 1 && datas[indexPath.row].check == false {
            for i in 1...datas[indexPath.row].child.count {
                if !datas[indexPath.row].child[i - 1].check {
                    count += datas[indexPath.row + i].child.count
                    datas[indexPath.row + i].check = true
                }
            }
            return count + datas[indexPath.row].child.count
        } else {
            return datas[indexPath.row].child.count
        }
    }
    
    func insertRows(at indexPath: IndexPath) {
        let data = DataManager(name: "Add row", level: 3)
        datas[indexPath.row].child.insert(data, at: 0)
        datas.insert(data, at: indexPath.row + 1)
    }
    
    func viewModelForItems(at indexPath: IndexPath) -> HomeCellViewModel {
        return HomeCellViewModel(data: datas[indexPath.row], indexPath: indexPath, numberOfChildren: datas[indexPath.row].child.count)
    }
}
