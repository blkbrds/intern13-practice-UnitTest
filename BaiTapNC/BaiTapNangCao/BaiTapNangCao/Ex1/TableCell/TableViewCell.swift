//
//  Ex1TableViewCell.swift
//  BaiTapNangCao
//
//  Created by MBA0144 on 5/3/19.
//  Copyright © 2019 MBA0144. All rights reserved.
//

import UIKit

protocol TableViewCellDelegate: class {
    func cell(_ cell: TableViewCell, needPerformAction action: TableViewCell.Action)
}

final class TableViewCell: UITableViewCell {

    enum Action {
        case addRow
    }

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var levelConstrains: NSLayoutConstraint!
    @IBOutlet private weak var addButton: UIButton!

    weak var delegate: TableViewCellDelegate?

    var viewModel: TableCellViewModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func updateView() {
        fillColor()
        configAddButton()
        levelConstrains.constant = CGFloat(viewModel?.schema.depth ?? 0) * 20
        titleLabel.text = viewModel?.schema.title
        subTitleLabel.text = "Number of children: \(viewModel?.schema.childs.count ?? 0)"
    }

    private func fillColor() {
        switch viewModel?.schema.depth {
        case 1:
            backgroundColor = #colorLiteral(red: 0.8009479642, green: 0.9305594563, blue: 0.9848075509, alpha: 1)
        case 2:
            backgroundColor = #colorLiteral(red: 0.8736486435, green: 0.9694783092, blue: 0.8469971418, alpha: 1)
        default:
            backgroundColor = .white
        }
    }

    private func configAddButton() {
        if let isOpen = viewModel?.schema.isOpen {
            if isOpen {
                addButton.isHidden = false
            } else {
                addButton.isHidden = true
            }
        }
    }

    @IBAction func addButtonTouchUpInside(_ sender: Any) {
        delegate?.cell(self, needPerformAction: .addRow)
    }
}
