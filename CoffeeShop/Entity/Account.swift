//
//  Account.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 02.04.2024.
//

import Foundation

struct Account: Codable {
    let token: String
    let name: String
    let email: String
    let password: String
    let adress: AdressOfUser?
}

struct AdressOfUser: Codable {
    let lon: Double
    let lat: Double
    let number: Int
}
