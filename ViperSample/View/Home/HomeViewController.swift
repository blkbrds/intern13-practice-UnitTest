//
//  HomeViewController.swift
//  DemoViper
//
//  Created by Van Le H. on 3/29/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import UIKit

fileprivate struct Defination {
    static let homeCellIdentifier = "HomeCell"
}

protocol HomeView: class {
    var eventHandler: HomeEventHandler? { get set }
    func updateView(with fruits: [Fruit])
}

final class HomeViewController: UIViewController, HomeView {
    
    var eventHandler: HomeEventHandler?
    
    // MARK: - Property
    @IBOutlet weak var tableView: UITableView!
    
    private var fruits: [Fruit] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        title = "HOME"
        configTableView()
        eventHandler?.viewDidLoad()
    }
    
    func updateView(with fruits: [Fruit]) {
        self.fruits = fruits
        tableView.reloadData()
    }
    
    private func configTableView() {
        let nib = UINib(nibName: Defination.homeCellIdentifier, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: Defination.homeCellIdentifier)
        tableView.rowHeight = 65
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Defination.homeCellIdentifier) as? HomeCell
            else { return UITableViewCell() }
        let fruit = fruits[indexPath.row]
        cell.updateView(name: fruit.name, price: fruit.price)
        return cell
    }
}
