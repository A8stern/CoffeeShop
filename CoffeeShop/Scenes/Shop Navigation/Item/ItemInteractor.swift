//
//  ItemInteractor.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 11.04.2024.
//

import Foundation

class ItemInteractor{
    var presenter: ItemPresenter?
    var item: Item?
    
    func getItem() -> Item {
        return item ?? Item(type: TypeOfFood(name: ""), name: "", price: "", picture: "", description: "")
    }
   
}
