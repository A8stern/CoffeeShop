//  ItemsDataHandler.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 01.04.2024.
//

import Foundation

class ItemsDataHandler {
    
    static let shared = ItemsDataHandler()
    
    private init() {}
    
    func loadItems() -> [Item] {
        guard let url = Bundle.main.url(forResource: "Items", withExtension: "json") else {
            print("Items.json not found.")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let items = try decoder.decode([Item].self, from: data)
            return items
        } catch {
            print("Error decoding JSON: \(error)")
            return []
        }
    }
}


