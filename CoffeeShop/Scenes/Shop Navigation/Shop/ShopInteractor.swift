//
//  ShopInteractor.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 29.03.2024.
//

import Foundation

class ShopInteractor{
    var presenter: ShopPresenter?
    
    func getItems() -> [Item] {
        let itemData: [Item] = ItemsDataHandler.shared.loadItems()
        print(itemData)
        return itemData
    }
    
    func getTypes() -> [TypeOfFood] {
        let typesData: [TypeOfFood] = TypesDataHandler.shared.loadTypesOfFood()
        print(typesData)
        return typesData
    }
    
    func getPrice() -> Double {
        return CartDataHandler.shared.calculateTotalPrice()
    }
    
    func wasLoggedInAndGaveAddress() -> Bool {
        guard let user = getUser() else {
            print("No user found")
            return false
        }
            
        if (user.addressName == "") {
            return false
        }
            
        return true
    }
    
    private func getUser() -> User? {
        guard let email = getEmail() else {
            print("No email found")
            return nil
        }
        return CoreDataUserManager.shared.fetchUser(with: email) ?? User()
    }
    
    private func getEmail() -> String? {
        return UserDataHandler.shared.loadEmailData()
    }
}
