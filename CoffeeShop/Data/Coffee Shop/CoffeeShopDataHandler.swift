//
//  CoffeeShopDataHandler.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 11.04.2024.
//

import Foundation

class CoffeeShopDataHandler {
    static let shared = CoffeeShopDataHandler()
    
    private init() {}
    
    func loadShops() -> [CoffeeShop] {
        guard let url = Bundle.main.url(forResource: "CoffeeShop", withExtension: "json") else {
            print("Items.json not found.")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let shops = try decoder.decode([CoffeeShop].self, from: data)
            return shops
        } catch {
            print("Error decoding JSON: \(error)")
            return []
        }
    }
}
