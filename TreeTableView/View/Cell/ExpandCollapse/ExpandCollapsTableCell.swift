//
//  ExpandCollapsTableCell.swift
//  TreeTableView
//
//  Created by MBA0010 on 5/2/19.
//  Copyright © 2019 MBA0010. All rights reserved.
//

import UIKit

protocol ExpandCollapsTableCellDelegate: class {
    func cell(_ cell: UITableViewCell, needPerForm action: ExpandCollapsTableCell.Action)
}

final class ExpandCollapsTableCell: UITableViewCell {

    enum Action {
        case reloadData(child: [Tree])
        case adjustHeighOfCell()
    }

    @IBOutlet private weak var tableView: UITableView!

    var viewModel = ExpandCollapsCellViewModel() {
        didSet {
            tableView.reloadData()
        }
    }
    var delegate: ExpandCollapsTableCellDelegate?
    var heightOfCell: CGFloat = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        configTableView()
    }

    private func configTableView() {
        tableView.register(TableCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ExpandCollapsTableCell: UITableViewDataSource {

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

        let cell = tableView.dequeue(TableCell.self)
        cell.viewModel = viewModel.viewModelForItem(at: indexPath) as? TableCellViewModel ?? TableCellViewModel()
        cell.delegate = self
        return cell
    }
}

extension ExpandCollapsTableCell: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            viewModel.datas[indexPath.section].isOpen = !viewModel.datas[indexPath.section].isOpen
            tableView.reloadSections([indexPath.section], with: .fade)
            delegate?.cell(self, needPerForm: .adjustHeighOfCell())
        }
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { [weak self] _, indexPath in
            guard let this = self,
                let delegate = this.delegate else { return }
            if indexPath.row == 0 {
                this.viewModel.datas.remove(at: indexPath.section)
            } else {
                this.viewModel.datas[indexPath.section].child.remove(at: indexPath.row - 1)
            }
            delegate.cell(this, needPerForm: .reloadData(child: this.viewModel.datas))
        }
        return [deleteAction]

    }
}

extension ExpandCollapsTableCell: TableCellDelegate {

    func cell(_ cell: UITableViewCell, needPerform action: TableCell.Action) {
        switch action {
        case .addChildCell:
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            viewModel.datas[indexPath.section].child.insert(Tree(title: "Added value", child: [], isOpen: false), at: 0)
            delegate?.cell(self, needPerForm: .reloadData(child: viewModel.datas))
        }
    }
}
