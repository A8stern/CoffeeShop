//
//  MapInteractor.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 30.03.2024.
//

import Foundation

class MapInteractor {
    var presenter: MapPresenter?
    
    func loadShops() -> [CoffeeShop]{
        let coffeeShops: [CoffeeShop] = CoffeeShopDataHandler.shared.loadShops()
        print(coffeeShops)
        return coffeeShops
    }
    
}
