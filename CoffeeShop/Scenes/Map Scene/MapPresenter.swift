//
//  MapPresenter.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 30.03.2024.
//

import Foundation

class MapPresenter {
    weak var view: MapViewController?
    var interactor: MapInteractor?
    var router: MapRouter?
    var shops: [CoffeeShop] = []
    
    func viewDidLoad() {
        shops = interactor?.loadShops() ?? []
        view?.setupPlacemarks(with: shops)
        view?.setupCollection(with: shops)
    }
    
}
