//
//  ShopPresenter.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 29.03.2024.
//

import Foundation

class ShopPresenter {
    weak var view: ShopViewController?
    var interactor: ShopInteractor?
    var router: ShopRouter?
    
    func viewDidLoad() {
        let items = interactor?.getItems()
        let types = interactor?.getTypes()
        
        view?.typesSetValues(with: types ?? [])
        view?.itemsSetValues(with: types ?? [], items: items ?? [])
        
        updatePrice()
    }
    
    func updatePrice() {
        guard let price = interactor?.getPrice() else { return }
        view?.buttonSetPrice(with: price)
    }
    
    func toItemVC(with item: Item) {
        router?.pushItemViewController(with: item)
    }
    
    func buttonTapped() {
        if (interactor?.wasLoggedInAndGaveAddress() == true){
            router?.pushCartViewController()
        } else {
            print("Log in or choose adress of delivery")
            view?.showErrorMessage("Log in error")
        }
    }
}
