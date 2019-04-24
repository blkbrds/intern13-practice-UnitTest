//
//  MockHomeView.swift
//  ViperSampleTests
//
//  Created by MBA0265P on 4/23/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class MockHomeViewController: HomeView {
    
    var eventHandler: HomeEventHandler?
    
    var fruits: [Fruit] = [Fruit()]
    
    func updateView(with fruits: [Fruit]) {
        self.fruits = fruits
    }
}
