//
//  UserPresenter.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 10.04.2024.
//

import Foundation

class UserPresenter {
    weak var view: UserViewController?
    var interactor: UserInteractor?
    var router: UserRouter?
    
    func viewDidAppear() {
        interactor?.viewDidLoad()
        view?.changeName(name: interactor?.fetchName() ?? "")
        let lat = interactor?.fetchCoords().0 ?? 1000
        let lon = interactor?.fetchCoords().1 ?? 1000
        if (lat != 1000) {
            view?.changeLocation(latitude: lat, longitude: lon)
            view?.changeAdress(adressName: interactor?.fetchAdress().0 ?? "", flat: interactor?.fetchAdress().1 ?? 0)
        }
    }
    
    func buttonTapped() {
        interactor?.deleteUser()
        router?.popToRootViewController()
    }
    
    func mapTapped() {
        router?.pushUserDeliveryViewController()
    }
    
    func popToRoot() {
        router?.popToRootViewController()
    }
}
