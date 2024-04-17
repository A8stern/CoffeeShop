//
//  UserInteractor.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 10.04.2024.
//

import Foundation

class UserInteractor {
    var presenter: UserPresenter?
    var user: User?
    
    func viewDidLoad() {
        getUser()
    }
    
    private func getUser() {
        guard let email = getEmail() else {
            print("No email found")
            return
        }
        user = CoreDataUserManager.shared.fetchUser(with: email)
    }
    
    func deleteUser(){
        UserDataHandler.shared.deleteEmailData()
    }
    
    private func getEmail() -> String? {
        return UserDataHandler.shared.loadEmailData()
    }
    
    func fetchName() -> String? {
        return user?.name
    }
    
    func fetchAdress() -> (String?, Int16?) {
        return (user?.addressName, user?.flat)
    }
    
    func fetchCoords() -> (Double?, Double?) {
        return (user?.lat, user?.lon)
    }
}
