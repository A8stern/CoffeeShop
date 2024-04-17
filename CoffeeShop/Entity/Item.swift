//
//  Items.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 01.04.2024.
//

struct Item: Codable {
    let type: TypeOfFood
    let name: String
    let price: String
    let picture: String
    let description: String
}


