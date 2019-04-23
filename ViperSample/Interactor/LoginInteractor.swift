//
//  UserInteractor.swift
//  DemoViper
//
//  Created by Van Le H. on 3/28/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

protocol LoginInteractor {
    var output: LoginInteractorOutput? { get set }
    func login(email: String, password: String)
}

protocol LoginInteractorOutput {
    func didLogin(result: Result<User>)
}

final class DefaultLoginInteractor: LoginInteractor {
    private let userServices: UserServices?
    var output: LoginInteractorOutput?
    
    init(userServices: UserServices? = DefaultUserServices()) {
        self.userServices = userServices
    }
    
    func login(email: String, password: String) {
        userServices?.login(email: email, password: password, completion: { [weak self](result) in
            guard let self = self  else { return }
            switch result {
            case .success(let entity):
                let user = User(entity: entity)
                self.output?.didLogin(result: .success(user))
            case .failure(let error):
                self.output?.didLogin(result: .failure(error))
            }
        })
    }
}
