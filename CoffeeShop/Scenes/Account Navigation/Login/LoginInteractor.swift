//
//  LoginInterator.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 29.03.2024.
//

import Foundation

class LoginInteractor {
    var presenter: LoginPresenter?
    
    func loginUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        sendLoginRequest(login: email, password: password) { success, token, tokenLifetime in
            DispatchQueue.main.async {
                if success {
                    self.saveLoggedUser(email: email)
                    print("User logged in")
                    print(token, tokenLifetime)
                    completion(true)
                } else {
                    print("Incorrect email or password")
                    completion(false)
                }
            }
        }
    }
    
    private func saveLoggedUser(email: String) {
        UserDataHandler.shared.saveEmailData(email: email)
        print("Saved email data")
    }
    
    private func sendLoginRequest(login: String, password: String, completion: @escaping (Bool, String, Int) -> Void) {
        let url = URL(string: "http://147.78.66.203:3210/auth/login")!
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


