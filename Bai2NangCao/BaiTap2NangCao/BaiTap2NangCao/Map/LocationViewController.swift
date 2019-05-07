//
//  LocationViewController.swift
//  BaiTap2NangCao
//
//  Created by MBA0023 on 5/6/19.
//  Copyright © 2019 MBA0023. All rights reserved.
//

import UIKit

final class LocationViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var radiusTextField: UITextField!

    var viewModel = LocationViewModel()
    let identifier = "identifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        configTableView()
        getData()
    }

    func configTableView() {
        tableView.register(UINib(nibName: "LocationCell", bundle: nil), forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }

    func getData() {
        viewModel.getData()
    }

    @IBAction private func getInfoButtonTouchUpInside(_ sender: Any) {
        let vc = MapViewController()
        guard let radiusText = radiusTextField.text, let radius = Double(radiusText) else { return }
        vc.viewModel = viewModel.viewModelForMapView(radius: radius)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LocationViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? LocationCell else { return UITableViewCell() }
        cell.viewModel = viewModel.viewModelForItems(at: indexPath)
        return cell
    }
}

extension LocationViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectLocation(at: indexPath)
    }
}
