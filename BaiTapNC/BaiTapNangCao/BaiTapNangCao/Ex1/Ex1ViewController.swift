//
//  Ex1ViewController.swift
//  BaiTapNangCao
//
//  Created by MBA0144 on 5/3/19.
//  Copyright © 2019 MBA0144. All rights reserved.
//

import UIKit

final class Ex1ViewController: UIViewController {

    @IBOutlet private  weak var tableView: UITableView!

    private let id = "TableViewCell"
    var viewModel: Ex1ViewModel = Ex1ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        getDataForTableView()
    }

    private func configView() {
        configTableView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTouchUpInside))
    }

    private func configTableView() {
        tableView.register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func getDataForTableView() {
        viewModel.getRootBranch()
    }

    @objc private func editButtonTouchUpInside() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTouchUpInside))
        tableView.isEditing = true
    }

    @objc private func doneButtonTouchUpInside() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTouchUpInside))
        tableView.isEditing = false
    }
}

extension Ex1ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.tableCellViewModel(indexPath: indexPath)
        cell.delegate = self
        return cell
    }
}

extension Ex1ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = viewModel.tempDatas[indexPath.row]
        guard !data.childs.isEmpty else { return }
        if data.isOpen {
            viewModel.deleteData(data: data)
            tableView.deleteRows(at: viewModel.deleteIndexPaths, with: .none)
        } else {
            viewModel.insertData(data: data)
            tableView.insertRows(at: viewModel.insertIndexPaths, with: .none)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension Ex1ViewController: TableViewCellDelegate {
    func cell(_ cell: TableViewCell, needPerformAction action: TableViewCell.Action) {
        switch action {
        case .addRow:
            print("xxx")
        }
    }
}
