//
//  CartPresenter.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 12.04.2024.
//

import Foundation

class CartPresenter {
    weak var view: CartViewController?
    var interactor: CartInteractor?
    var router: CartRouter?
    
    func viewDidLoad() {
        guard let cart = interactor?.getCart() else { return }
        view?.setupCollection(with: cart)
        updatePrice()
    }
    
    func updatePrice() {
        guard let price = interactor?.getPrice() else { return }
        view?.setupButton(with: price)
    }
    
    func makeOrder() {
        guard let user = interactor?.getUser() else { return }
        guard let cart = interactor?.getCart() else { return }
        print ("Name: \(user.name ?? ""), adress: \(user.addressName ?? ""), flat: \(user.flat), latitude: \(user.lat), longtitude: \(user.lon), cart: \(cart)")
    }
}
