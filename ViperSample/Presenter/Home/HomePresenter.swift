//
//  HomePresenter.swift
//  DemoViper
//
//  Created by Van Le H. on 3/29/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

protocol HomeEventHandler {
    func viewDidLoad()
}

final class DefaultHomePresenter: HomeEventHandler {
    
    // MARK: - Properties
    private weak var view: HomeView?
    private var router: HomeRouter?
    private var fruitInteractor: ListFruitInteractor?
    
    init(view: HomeView?, router: HomeRouter?, fruitInteractor: ListFruitInteractor?) {
        self.view = view
        self.router = router
        self.fruitInteractor = fruitInteractor
        self.fruitInteractor?.output = self
    }
    
    func updateView(fruits: [Fruit]) {
        view?.updateView(with: fruits)
    }
    
    func showError(error: Error) {
        router?.showError(error: error)
    }
    
    // MARK: - HomeEventHandler implamentation
    func viewDidLoad() {
        fruitInteractor?.getFruits()
    }
}

extension DefaultHomePresenter: ListFruitInteractorOutput {

    func didFetchFruit(result: Result<[Fruit]>) {
        switch result {
        case .success(let fruits):
            updateView(fruits: fruits)
        case .failure(let error):
            showError(error: error)
        }
    }
}
