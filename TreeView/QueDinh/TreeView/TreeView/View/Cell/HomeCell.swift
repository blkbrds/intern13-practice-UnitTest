//
//  HomeCell.swift
//  TreeView
//
//  Created by MBA0023 on 4/15/19.
//  Copyright © 2019 MBA0023. All rights reserved.
//

import UIKit

protocol HomeCellDelegate: class {
    func cell(_ view: HomeCell, needPerformAction action: HomeCell.Action)
}

final class HomeCell: UITableViewCell {
    
    enum Action {
        case addRow(indexPath: IndexPath)
    }

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var leftSpaceNSLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var backgView: UIView!
    @IBOutlet private weak var numberOfChildrenLabel: UILabel!
    @IBOutlet private weak var leftSpaceChildrenNSLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var addRowButton: UIButton!
    
    weak var delegate: HomeCellDelegate?
    
    var viewModel: HomeCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        guard let name = viewModel?.name,
            let numberOfChildren = viewModel?.numberOfChildren,
            let check = viewModel?.check else { return }
        nameLabel.text = name
        numberOfChildrenLabel.text = "Number of children: " + String(numberOfChildren)
        if viewModel?.level == 2 {
            backgView.backgroundColor = #colorLiteral(red: 0.367679217, green: 0.06057613823, blue: 0.9863989637, alpha: 0.7513479313)
            leftSpaceNSLayoutConstraint.constant = CGFloat(50)
            leftSpaceChildrenNSLayoutConstraint.constant = CGFloat(50)
            if !check {
                addRowButton.isHidden = false
            } else {
                addRowButton.isHidden = true
            }
        } else if viewModel?.level == 3 {
            backgView.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 0.7229038292)
            leftSpaceNSLayoutConstraint.constant = CGFloat(80)
            leftSpaceChildrenNSLayoutConstraint.constant = CGFloat(80)
        } else if viewModel?.level == 1 {
            backgView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            leftSpaceNSLayoutConstraint.constant = CGFloat(25)
            leftSpaceChildrenNSLayoutConstraint.constant = CGFloat(25)
        }
    }
    
    @IBAction private func addRowButtonTouchUpInside(_ sender: Any) {
        guard let indexPath = viewModel?.indexPath else { return }
        delegate?.cell(self, needPerformAction: .addRow(indexPath: indexPath))
    }
}
