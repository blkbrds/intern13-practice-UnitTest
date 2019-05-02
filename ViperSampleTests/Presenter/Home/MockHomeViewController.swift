//
//  MockHomeViewController.swift
//  ViperSampleTests
//
//  Created by MBA0023 on 4/22/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class MockHomeViewController: HomeView {

    var eventHandler: HomeEventHandler?
    var fruits: [Fruit] = []
    
    func updateView(with fruits: [Fruit]) {
        self.fruits = fruits
    }
}
