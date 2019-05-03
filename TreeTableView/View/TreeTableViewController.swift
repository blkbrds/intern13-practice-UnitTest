//
//  TreeTableViewController.swift
//  TreeTableView
//
//  Created by MBA0010 on 5/2/19.
//  Copyright © 2019 MBA0010. All rights reserved.
//

import UIKit
import MVVM
import SwiftUtils

final class TreeTableViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel = TreeTableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    private func configTableView() {
        tableView.register(TableCell.self)
        tableView.register(ExpandCollapsTableCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension TreeTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeue(TableCell.self)
            cell.viewModel = viewModel.viewModelForItem(at: indexPath) as? TableCellViewModel ?? TableCellViewModel()
            cell.delegate = self
            return cell
        }
        
        let cell = tableView.dequeue(ExpandCollapsTableCell.self)
        cell.viewModel = viewModel.viewModelForItem(at: indexPath) as? ExpandCollapsCellViewModel ?? ExpandCollapsCellViewModel()
        cell.delegate = self
        return cell
    }
    
}

extension TreeTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 70
        } else {
            switch indexPath.section {
            case 0:
                var height =  CGFloat(viewModel.datas[0].child.count * 70)
                for chil in viewModel.datas[0].child where chil.isOpen {
                    height += CGFloat(chil.child.count * 70)
                }
                return height
            case 1:
                var height =  CGFloat(viewModel.datas[1].child.count * 70)
                for chil in viewModel.datas[1].child where chil.isOpen {
                    height += CGFloat(chil.child.count * 70)
                }
                return height
            case 2:
                var height =  CGFloat(viewModel.datas[2].child.count * 70)
                for chil in viewModel.datas[2].child where chil.isOpen {
                    height += CGFloat(chil.child.count * 70)
                }
                return height
            default:
                return 70
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            viewModel.datas[indexPath.section].isOpen = !viewModel.datas[indexPath.section].isOpen
        default:
            break
        }
        tableView.reloadSections([indexPath.section], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if indexPath.row == 0 {
            let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { _, indexPath in
                let alert = UIAlertController(title: nil, message: "Do you want delete?", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "Yes", style: .cancel) { [weak self] _ in
                    guard let this = self else { return }
                    this.tableView.beginUpdates()
                    this.viewModel.datas.remove(at: indexPath.section)
                    tableView.deleteSections([indexPath.section], with: .automatic)
                    this.tableView.endUpdates()
                }
                let action2 = UIAlertAction(title: "No", style: .default) { _ in }
                alert.addAction(action1)
                alert.addAction(action2)
                self.present(alert, animated: true, completion: nil)
            }
            return [deleteAction]
        }
        return nil
    }
}

extension TreeTableViewController: ExpandCollapsTableCellDelegate {
    
    func cell(_ cell: UITableViewCell, needPerForm action: ExpandCollapsTableCell.Action) {
        switch action {
        case .adjustHeighOfCell():
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            tableView.reloadSections([indexPath.section], with: .automatic)
        case .reloadData(let child):
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            viewModel.datas[indexPath.section].child = child
            tableView.reloadSections([indexPath.section], with: .automatic)
        }
    }
}

extension TreeTableViewController: TableCellDelegate {
    
    func cell(_ cell: UITableViewCell, needPerform action: TableCell.Action) {
        switch action {
        case .addChildCell(let title):
            for data in viewModel.datas where data.title == title {
                data.child.insert(Tree(title: "Added value", child: [], isOpen: false), at: 0)
            }
        }
        tableView.reloadData()
    }
}
