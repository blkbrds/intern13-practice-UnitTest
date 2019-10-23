//
//  Ex1ViewModel.swift
//  BaiTapNangCao
//
//  Created by MBA0144 on 5/3/19.
//  Copyright © 2019 MBA0144. All rights reserved.
//

import Foundation

final class Ex1ViewModel {

    private var rootData = Dummy.baseData
    private var showRow = 0
    var deleteIndexPaths: [IndexPath] = []
    var insertIndexPaths: [IndexPath] = []
    var tempDatas: [Schema] = []

    func getRootBranch() {
        for data in rootData {
            getOpenBranch(data: data)
        }
    }

    func numberOfRowInSection() -> Int {
        return tempDatas.count
    }

    func getOpenBranch(data: Schema) {
        tempDatas.append(data)
        if data.isOpen {
            for child in data.childs {
                getOpenBranch(data: child)
            }
        }
    }

    func tableCellViewModel(indexPath: IndexPath) -> TableCellViewModel {
        return TableCellViewModel(schema: tempDatas[indexPath.row])
    }

    func hideData(data: Schema) {
        deleteIndexPaths = []
        getChildIndexPaths(data: data)
        data.isOpen = false
        for index in deleteIndexPaths.reversed() {
            tempDatas.remove(at: index.row)
        }
    }

    private func getChildIndexPaths(data: Schema) {
        if data.isOpen {
            for child in data.childs {
                guard let childRow = tempDatas.firstIndex(where: { $0.id == child.id }) else { return }
                let indexPath = IndexPath(row: childRow, section: 0)
                deleteIndexPaths.append(indexPath)
                if child.isOpen {
                    getChildIndexPaths(data: child)
                }
            }
        }
    }

    func showData(data: Schema) {
        guard !data.childs.isEmpty else { return }
        insertIndexPaths = []
        getShowIndexPaths(data: data)
        data.isOpen = true
    }

    private func getShowIndexPaths(data: Schema) {
        guard let row = tempDatas.firstIndex(where: { $0.id == data.id }) else { return }
        showRow = row + 1
        for child in data.childs {
            let childRow = showRow
            let indexPath = IndexPath(row: childRow, section: 0)
            insertIndexPaths.append(indexPath)
            tempDatas.insert(child, at: childRow)
            showRow += 1
            if child.isOpen {
                getShowIndexPaths(data: child)
            }
        }
    }

    func deleteData(data: Schema) {
        deleteIndexPaths = []
        guard let row = tempDatas.firstIndex(where: { $0.id == data.id }) else { return }
        deleteIndexPaths.append(IndexPath(row: row, section: 0))
        getChildIndexPaths(data: data)
        for index in deleteIndexPaths.reversed() {
            tempDatas.remove(at: index.row)
        }
    }

    func addData(indexPath: IndexPath) {
        guard let lastID = tempDatas.last?.id else {
            tempDatas.append(Schema())
            return
        }
        let schema = Schema(title: "Added value", id: lastID + 1)
        schema.isOpen = false
        tempDatas.insert(schema, at: indexPath.row)
    }
}

extension Ex1ViewModel {

    struct Dummy {
        static let baseData: [Schema] = {
            let dell = Schema(title: "Dell", id: 16)
            let asus = Schema(title: "Asus", id: 17)
            let notebook1 = Schema(title: "Notebook 1", id: 1)
            let notebook2 = Schema(title: "Notebook 2", id: 2)
            let notebook3 = Schema(title: "Notebook 3", id: 3)
            let computer1 = Schema(title: "Computer 1", id: 4)
            computer1.childs = [notebook1, notebook2, notebook3]
            let computer2 = Schema(title: "Computer 2", id: 5)
            let computer3 = Schema(title: "Computer 3", id: 6)
            let phone1 = Schema(title: "Phone 1", id: 7)
            let phone2 = Schema(title: "Phone 2", id: 8)
            let phone3 = Schema(title: "Phone 3", id: 9)
            let car1 =  Schema(title: "Car 1", id: 10)
            let car2 = Schema(title: "Car 2", id: 11)
            let car3 = Schema(title: "Car 3", id: 12)
            let phones = Schema(title: "Phones", id: 13)
            phones.childs = [phone1, phone2, phone3]
            let computers = Schema(title: "Computers", id: 14)
            computers.childs = [computer1, computer2, computer3]
            let cars = Schema(title: "Cars", id: 15)
            cars.childs = [car1, car2, car3]
            return [phones, computers, cars]
        }()
    }
}
