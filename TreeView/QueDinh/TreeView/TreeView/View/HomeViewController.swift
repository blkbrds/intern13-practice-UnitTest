//
//  HomeViewController.swift
//  TreeView
//
//  Created by MBA0023 on 4/15/19.
//  Copyright © 2019 MBA0023. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var identifier = "identifier"
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configTableView()
    }
    
    func configTableView() {
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItem()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? HomeCell else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel.viewModelForItems(at: indexPath)
        cell.delegate = self
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let number = viewModel.datas[indexPath.row].child.count
        if number != 0 {
            if viewModel.datas[indexPath.row].check {
                viewModel.addRow(atIndexPath: indexPath)
                var indexPaths = [IndexPath]()
                for i in 1...number {
                    let indexPath = IndexPath(row: indexPath.row + i, section: 0)
                    indexPaths.append(indexPath)
                }
                viewModel.datas[indexPath.row].check = false
                tableView.insertRows(at: indexPaths, with: .bottom)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.tableView.reloadData()
                }
            } else {
                let number = viewModel.numberOfItemNeedDelete(at: indexPath)
                viewModel.removeRow(at: indexPath, num: number)
                var indexPaths = [IndexPath]()
                for i in 1...number {
                    let indexPath = IndexPath(row: indexPath.row + i, section: 0)
                    indexPaths.append(indexPath)
                }
                tableView.deleteRows(at: indexPaths, with: .bottom)
                viewModel.datas[indexPath.row].check = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension HomeViewController: HomeCellDelegate {
    
    func cell(_ view: HomeCell, needPerformAction action: HomeCell.Action) {
        switch action {
        case .addRow(let indexPath):
            viewModel.insertRows(at: indexPath)
            var indexPaths = [IndexPath]()
            let indexPath = IndexPath(row: indexPath.row + 1, section: 0)
            indexPaths.append(indexPath)
            tableView.insertRows(at: indexPaths, with: .left)
            viewModel.datas[indexPath.row - 1].check = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.tableView.reloadData()
            }
        }
    }
}
