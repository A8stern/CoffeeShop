//
//  TypesDataHandler.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 01.04.2024.
//

import Foundation

class TypesDataHandler {
    
    static let shared = TypesDataHandler()
    
    private init() {}
    
    func loadTypesOfFood() -> [TypeOfFood] {
        guard let url = Bundle.main.url(forResource: "TypesOfFood", withExtension: "json") else {
            print("TypesOfFood.json not found.")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let types = try decoder.decode([TypeOfFood].self, from: data)
            return types
        } catch {
            print("Error decoding JSON: \(error)")
            return []
        }
    }
}

