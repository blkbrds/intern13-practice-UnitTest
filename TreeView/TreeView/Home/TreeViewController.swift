//
//  TreeViewController.swift
//  TreeView
//
//  Created by MBA0265P on 5/2/19.
//  Copyright © 2019 MBA0265P. All rights reserved.
//

import UIKit

final class TreeViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel = TreeViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "THINGS"
        
        // UI
        configUI()
        // Data
        getData()
    }
    
    // MARK: - Privates
    private func configUI() {
        let cellNib = UINib(nibName: Identifier.cell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: Identifier.cell)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getData() {
        viewModel.getData()
    }
}

// MARK: - UITableViewDataSource
extension TreeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.cell, for: indexPath) as? TreeCell else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TreeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let childrenOfObjects = viewModel.dataObjects[indexPath.row].children
        
        if childrenOfObjects.count != 0 {
            if viewModel.dataObjects[indexPath.row].isExpanded == false {
                
                viewModel.dataObjects[indexPath.row].isExpanded = true
                
                let totalChildrenIsAdded = childrenOfObjects.count
                for i in 0..<totalChildrenIsAdded {
                    viewModel.dataObjects.insert(childrenOfObjects[i], at: indexPath.row + i + 1)
                }
                
                var indexs = [IndexPath]()
                for i in 1...totalChildrenIsAdded {
                    let index = IndexPath(row: indexPath.row + i, section: 0)
                    indexs.append(index)
                }
                
                tableView.insertRows(at: indexs, with: .none)
                tableView.reloadData()
            } else {
                
                var totalChildrenNeedDelete = childrenOfObjects.count
                
                if viewModel.dataObjects[indexPath.row].level == 0 && viewModel.dataObjects[indexPath.row].isExpanded == true {
                    for i in 0..<totalChildrenNeedDelete {
                        if viewModel.dataObjects[indexPath.row].children[i].isExpanded == true {
                            totalChildrenNeedDelete += viewModel.dataObjects[indexPath.row].children.count
                            viewModel.dataObjects[indexPath.row].isExpanded = false
                        }
                    }
                }
                
                viewModel.dataObjects[indexPath.row].isExpanded = false
                for _ in 0..<totalChildrenNeedDelete {
                    viewModel.dataObjects.remove(at: indexPath.row + 1)
                }
                
                var indexs = [IndexPath]()
                for i in 1...totalChildrenNeedDelete {
                    let index = IndexPath(row: indexPath.row + i, section: 0)
                    indexs.append(index)
                }
                
                tableView.beginUpdates()
                tableView.deleteRows(at: indexs, with: .automatic)
                tableView.endUpdates()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let childrenOfObject = viewModel.dataObjects[indexPath.row].children
        for _ in 0..<childrenOfObject.count {
            viewModel.dataObjects.remove(at: indexPath.row)
        }
        var indexs = [IndexPath]()
        for i in 0..<childrenOfObject.count {
            let index = IndexPath(row: indexPath.row + i, section: 0)
            indexs.append(index)
        }
        tableView.beginUpdates()
        tableView.deleteRows(at: indexs, with: .automatic)
        tableView.endUpdates()
    }
}

// MARK: - TreeCellDelegate
extension TreeViewController: TreeCellDelegate {
    
    func cell(_ cell: UITableViewCell, needsPerform action: TreeCell.Action) {
        switch action {
        case .didSelect(let indexPath):
            viewModel.addNewObject(at: indexPath)
            var indexs = [IndexPath]()
            let index = IndexPath(row: indexPath.row + 1, section: 0)
            indexs.append(index)
            tableView.insertRows(at: indexs, with: .automatic)
            tableView.reloadData()
        }
    }
}
