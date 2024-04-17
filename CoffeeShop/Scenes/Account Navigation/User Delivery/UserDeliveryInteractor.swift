//
//  UserDeliveryInteractor.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 10.04.2024.
//
import Foundation

class UserDeliveryInteractor {
    var presenter: UserDeliveryPresenter?
    var user: User?
    
    func viewDidLoad() {
        getUser()
    }
    
    private func getUser() {
        guard let email = getEmail() else {
            print("No email found")
            return
        }
        user = CoreDataUserManager.shared.fetchUser(with: email)
    }
    
    private func getEmail() -> String? {
        return UserDataHandler.shared.loadEmailData()
    }
    
    func reverseGeocodeWithLocationIQ(latitude: Double, longitude: Double, completion: @escaping (String?) -> Void) {
        let urlString = "https://eu1.locationiq.com/v1/reverse.php?key=pk.a641849eb105576437b95f25f43b03cc&lat=\(latitude)&lon=\(longitude)&format=json"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let geoData = try decoder.decode(LocationIQResponse.self, from: data)
                let response = "\(geoData.address?.country ?? ""), \(geoData.address?.city ?? ""), \(geoData.address?.road ?? ""), \(geoData.address?.houseNumber ?? "")"
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    func saveAdress(adress: String, lat: Double,
                    lon: Double, flat: Int16) {
        guard let email = getEmail() else {
            print("No email found")
            return
        }
        CoreDataUserManager.shared.updateUserAdress(with: email, adress: adress, lat: lat, lon: lon, flat: flat)
    }
}
