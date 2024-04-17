//
//  RegisterPresenter.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 29.03.2024.
//

import Foundation

class RegisterPresenter {
    weak var view: RegisterViewController?
    var interactor: RegisterInteractor?
    var router: RegisterRouter?

    func registerButtonTapped(withName name: String?, email: String?, password: String?, confirmPassword: String?) {
        guard let name = name, !name.isEmpty,
              let email = email, !email.isEmpty,
              let password = password, !password.isEmpty,
              let confirmPassword = confirmPassword, !confirmPassword.isEmpty else {
            view?.showErrorMessage("Please fill in all fields.")
            return
        }
        
        guard password == confirmPassword else {
            view?.showErrorMessage("Passwords don't match.")
            return
        }
        
        guard validateName(name),
                validateEmail(email), validatePassword(password) else {
            view?.showErrorMessage("Invalid input. Please check your data and try again.")
            return
        }
        
        interactor?.registerUser(name: name, email: email,
                                 password: password, 
                                 completion: { [weak self] success in
            if success {
                self?.router?.navigateToUserViewController()
            } else {
                self?.view?.showErrorMessage("Register Failed")
            }
        })
    }
    
    private func validateName(_ name: String?) -> Bool {
        guard let name = name else { return false }
        let nameRegex = "^[A-Za-z]+$"
        return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: name)
    }
    
    private func validateEmail(_ email: String?) -> Bool {
        guard let email = email, email.contains("@") else { return false }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    private func validatePassword(_ password: String?) -> Bool {
        guard let password = password, password.count >= 5 && password.count <= 30 else { return false }
        let passwordRegex = "[A-Za-z0-9!#$%&'*+,-./:;<=>?@\\\\^_`|~]{5,30}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
}

