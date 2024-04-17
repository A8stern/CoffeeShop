//
//  RegisterInteractor.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 29.03.2024.
//

import Foundation

class RegisterInteractor {

    var presenter: RegisterPresenter?
    
    func registerUser(name: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            if let _ = CoreDataUserManager.shared.fetchUser(with: email) {
                print("User with this email is already registered")
                completion(false)
            } else {
                self.sendRegistrationRequest(login: email, password: password) { success, token, tokenLifetime in
                    DispatchQueue.main.async {
                        if success {
                            CoreDataUserManager.shared.createUser(name: name, email: email, password: password)
                            self.saveLoggedUser(email: email)
                            print(token, tokenLifetime)
                            completion(true)
                        } else {
                            print("API registration failed")
                            completion(false)
                        }
                    }
                }
            }
        }
    }
    
    private func saveLoggedUser(email: String) {
        UserDataHandler.shared.saveEmailData(email: email)
        print("Saved email data")
    }

    private func sendRegistrationRequest(login: String, password: String, completion: @escaping (Bool, String, Int) -> Void) {
        let url = URL(string: "http://147.78.66.203:3210/auth/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json = [
            "login": login,
            "password": password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
        } catch {
            print("Error: cannot create JSON")
            completion(false, "", 0)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let data = data else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completion(false, "", 0)
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let token = jsonObject["token"] as? String,
                       let tokenLifetime = jsonObject["tokenLifetime"] as? Int {
                        completion(true, token, tokenLifetime)
                    } else {
                        completion(false, "", 0)
                    }
                } catch {
                    print("Error parsing JSON response")
                    completion(false, "", 0)
                }
            } else {
                completion(false, "", 0)
            }
        }.resume()
    }
}
