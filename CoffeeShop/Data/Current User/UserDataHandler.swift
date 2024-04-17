//
//  UserDataHandler.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 10.04.2024.
//

import Foundation

class UserDataHandler {
    static let shared = UserDataHandler()
    
    private var filePath: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("emailData.json")
    }
    
    private init() {}
    
    func saveEmailData(email: String) {
        let dataDictionary: [String: Any] = ["email": email]
        do {
            let data = try JSONSerialization.data(withJSONObject: dataDictionary, options: [])
            try data.write(to: filePath)
        } catch {
            print("Failed to save email: \(error)")
        }
    }
    
    func loadEmailData() -> String? {
        do {
            let data = try Data(contentsOf: filePath)
            if let userDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let email = userDictionary["email"] as? String {
                return email
            }
        } catch {
            print("Failed to load email: \(error)")
        }
        return nil
    }

    func hasStoredEmailData() -> Bool {
        do {
            let data = try Data(contentsOf: filePath)
            if let dataDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               dataDictionary["email"] != nil {
                return true
            }
        } catch {
            print("Failed to check for stored email: \(error)")
        }
        return false
    }

    func deleteEmailData() {
        do {
            try FileManager.default.removeItem(at: filePath)
            print("Email data deleted successfully.")
        } catch {
            print("Failed to delete email data: \(error)")
        }
    }
}
