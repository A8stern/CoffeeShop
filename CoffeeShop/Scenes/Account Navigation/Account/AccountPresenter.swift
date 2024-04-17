//
//  AccountPresenter.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 31.03.2024.
//

import Foundation

class AccountPresenter {
    weak var view: AccountViewController?
    var interactor: AccountInteractor?
    var router: AccountRouter?
    
    func viewDidLoad() {
        //interactor?.fetchUser()
    }
    
    func loginButtonTapped() {
        router?.navigateToLoginViewController()
    }
    
    func regButtonTapped() {
        router?.navigateToRegisterViewController()
    }
}
