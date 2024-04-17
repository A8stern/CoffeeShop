//
//  CartInteractor.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 12.04.2024.
//

import Foundation

class CartInteractor{
    var presenter: CartPresenter?
    
    func getCart() -> [CartItem] {
        return CartDataHandler.shared.getCart()
    }
    
    func getPrice() -> Double {
        return CartDataHandler.shared.calculateTotalPrice()
    }
    
    func getUser() -> User {
        guard let email = getEmail() else {
            print("No email found")
            return User()
        }
        return CoreDataUserManager.shared.fetchUser(with: email) ?? User()
    }
    
    private func getEmail() -> String? {
        return UserDataHandler.shared.loadEmailData()
    }
}
