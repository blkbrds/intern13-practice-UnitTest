//
//  TreeCell.swift
//  TreeView
//
//  Created by MBA0265P on 5/2/19.
//  Copyright © 2019 MBA0265P. All rights reserved.
//

import UIKit

protocol TreeCellDelegate: class {
    func cell(_ cell: UITableViewCell, needsPerform action: TreeCell.Action)
}

final class TreeCell: UITableViewCell {
    
    // MARK: - Enum
    enum Action {
        case didSelect(indexPath: IndexPath)
    }
    
    // MARK: - Outlet
    @IBOutlet private weak var bgroundView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var leftNameNSLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leftDescriptionNSLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var addNewObjectButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: TreeCellDelegate?
    var viewModel: TreeCellModel? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Private
    private func updateView() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.name
        descriptionLabel.text = "Number of children is: \(String(describing: viewModel.children.count))"
        
        if viewModel.level == 1 {
            bgroundView.backgroundColor = .blue
            leftNameNSLayoutConstraint.constant = CGFloat(40)
            leftDescriptionNSLayoutConstraint.constant = CGFloat(40)
        } else if viewModel.level == 2 {
            bgroundView.backgroundColor = .green
            leftNameNSLayoutConstraint.constant = CGFloat(70)
            leftDescriptionNSLayoutConstraint.constant = CGFloat(70)
        } else {
            bgroundView.backgroundColor = .white
            leftNameNSLayoutConstraint.constant = CGFloat(12)
            leftDescriptionNSLayoutConstraint.constant = CGFloat(12)
        }
    }

    // MARK: - Action
    @IBAction func addNewObjectButtonTouchUpInside(_ sender: UIButton) {
        guard let indexPath = viewModel?.indexPath else { return }
        delegate?.cell(self, needsPerform: .didSelect(indexPath: indexPath))
    }
}
