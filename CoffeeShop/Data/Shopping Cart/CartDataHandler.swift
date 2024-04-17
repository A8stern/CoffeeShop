//  CartDataHandler.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 12.04.2024.
//

import Foundation

class CartDataHandler {
    
    static let shared = CartDataHandler()
    
    private let cartFilePath: URL = {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("cartData.json")
    }()
    
    private var cart: [CartItem] = []
    
    private init() {
        cart = loadCart()
    }
    
    func saveCart() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(cart)
            try data.write(to: cartFilePath)
        } catch {
            print("Failed to save cart: \(error)")
        }
    }
    
    func loadCart() -> [CartItem] {
        do {
            let data = try Data(contentsOf: cartFilePath)
            let decoder = JSONDecoder()
            let cart = try decoder.decode([CartItem].self, from: data)
            return cart
        } catch {
            print("Failed to load cart: \(error)")
            return []
        }
    }
    
    func addItemToCart(item: Item) {
        if let existingItemIndex = cart.firstIndex(where: { $0.item.name == item.name }) {
            cart[existingItemIndex].quantity += 1
        } else {
            let cartItem = CartItem(item: item, quantity: 1)
            cart.append(cartItem)
        }
        saveCart()
    }
    
    func removeItemFromCart(item: Item) {
        if let existingItemIndex = cart.firstIndex(where: { $0.item.name == item.name }) {
            cart.remove(at: existingItemIndex)
        }
        saveCart()
    }
    
    func removeAllItemsFromCart() {
        cart.removeAll()
        saveCart()
    }
    
    func updateItemQuantity(item: Item, quantity: Int) {
        if let existingItemIndex = cart.firstIndex(where: { $0.item.name == item.name }) {
            cart[existingItemIndex].quantity = quantity
        }
        saveCart()
    }
    
    func calculateTotalPrice() -> Double {
        var totalPrice = 0.0
        for cartItem in cart {
            let itemPrice = Double(cartItem.quantity) * Double(cartItem.item.price)!
            totalPrice += itemPrice
        }
        return totalPrice
    }
    
    func getCart() -> [CartItem] {
        return cart
    }
    
    func isItemInCart(item: Item) -> Bool {
        if cart.firstIndex(where: { $0.item.name == item.name }) != nil {
            return true
        }
        return false
    }
    
    func getItemQuantity(item: Item) -> Int {
        if let existingItemIndex = cart.firstIndex(where: { $0.item.name == item.name }) {
            return cart[existingItemIndex].quantity
        }
        return 0
    }
}
