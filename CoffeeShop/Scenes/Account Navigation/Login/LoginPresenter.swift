//
//  LoginPresenter.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 29.03.2024.
//

import Foundation

class LoginPresenter{
    weak var view: LoginViewController?
    var interactor: LoginInteractor?
    var router: LoginRouter?

    func loginButtonTapped(withEmail email: String?, password: String?) {
        guard let email = email, !email.isEmpty, let password = password, !password.isEmpty else {
            view?.showErrorMessage("Please fill in all fields.")
            return
        }

        interactor?.loginUser(email: email, password: password, completion: { [weak self] success in
            if success {
                self?.router?.navigateToUserViewController()
            } else {
                self?.view?.showErrorMessage("Login Failed")
            }
        })
    }
}


