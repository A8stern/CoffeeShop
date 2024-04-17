//
//  ItemPresenter.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 11.04.2024.
//

import Foundation

class ItemPresenter {
    weak var view: ItemViewController?
    var interactor: ItemInteractor?
    var router: ItemRouter?
    
    func viewDidLoad() {
        guard let item = interactor?.getItem() else { return }
        view?.setupUI(with: item)
    }
}
