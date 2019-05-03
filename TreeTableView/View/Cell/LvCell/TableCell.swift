//
//  TableCell.swift
//  TreeTableView
//
//  Created by MBA0010 on 5/2/19.
//  Copyright © 2019 MBA0010. All rights reserved.
//

import UIKit

protocol TableCellDelegate {
    func cell(_ cell: UITableViewCell, needPerform action: TableCell.Action)
}

final class TableCell: UITableViewCell {
    
    enum Action {
        case addChildCell(title: String)
    }

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var titleLeadingConstaint: NSLayoutConstraint!
    @IBOutlet private weak var subtitleLeadingConstain: NSLayoutConstraint!
    
    var viewModel = TableCellViewModel() {
        didSet {
            update()
        }
    }
    var delegate: TableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addButton.layer.cornerRadius = addButton.bounds.size.width / 2
    }
    
    private func update() {
        addButton.isHidden = !viewModel.isOpen
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        switch viewModel.type {
        case .lv1:
            backgroundColor = UIColor.yellow
            titleLeadingConstaint.constant = 0
            subtitleLeadingConstain.constant = 0
        case .lv2:
            backgroundColor = UIColor.green
            titleLeadingConstaint.constant = 35
            subtitleLeadingConstain.constant = 35
        case .lv3:
            backgroundColor = .gray
            titleLeadingConstaint.constant = 70
            subtitleLeadingConstain.constant = 70
        }
    }
    
    @IBAction private func addCellButtonTouchUpInSide(_ sender: UIButton) {
        guard let title = titleLabel.text else { return }
        delegate?.cell(self, needPerform: .addChildCell(title: title))
    }
}
