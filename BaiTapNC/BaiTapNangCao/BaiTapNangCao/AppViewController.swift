//
//  AppViewController.swift
//  BaiTapNC
//
//  Created by MBA0144 on 4/17/19.
//  Copyright © 2019 MBA0144. All rights reserved.
//

import UIKit

final class AppViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    let indentify = "tableCell"
    let vc1 = Ex1ViewController()
    let vc2 = Ex2ViewController()
    let vc3 = Ex3ViewController()
    let vc4 = Ex4ViewController()
    let vc5 = Ex5ViewController()
    let names = ["Bai tap 1", "Bai tap 2", "Bai tap 3", "Bai tap 4", "Bai tap 5"]
    lazy var exs = [vc1, vc2, vc3, vc4, vc5]

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    private func configView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: indentify)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension AppViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indentify, for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
}

extension AppViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = exs[indexPath.row]
        vc.navigationItem.title = names[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
