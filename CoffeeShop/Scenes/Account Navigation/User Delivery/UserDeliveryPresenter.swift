//
//  UserDeliveryPresenter.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 10.04.2024.
//

import Foundation

class UserDeliveryPresenter {
    weak var view: UserDeliveryViewController?
    var interactor: UserDeliveryInteractor?
    var router: UserDeliveryRouter?
    
    private var lat = 1000.0
    private var lon = 1000.0
    
    func viewDidAppear() {
        interactor?.viewDidLoad()
        
    }
    
    func tapOnMap(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
        interactor?.reverseGeocodeWithLocationIQ(latitude: lat, longitude: lon) { address in
            if let address = address {
                self.view?.changeText(adress: address)
            } else {
                print("Failed to fetch address")
            }
        }
    }
    
    func buttonTapped(adressName: String?, flat: String?) {
        guard let adressName = adressName, !adressName.isEmpty, let flat = flat, !flat.isEmpty else {
            view?.showErrorMessage("Please fill in all fields.")
            return
        }
        
        guard validateFlat(flat) else {
            view?.showErrorMessage("Invalid input. Please check your flat number and try again.")
            return
        }
        
        interactor?.saveAdress(adress: adressName, lat: lat, lon: lon, flat: Int16(flat) ?? 0)
        router?.popViewController()
    }
    
    private func validateFlat(_ flat: String?) -> Bool {
        guard let flat = flat else { return false }
        let flatRegex = "[0-9]{1,}"
        return NSPredicate(format: "SELF MATCHES %@", flatRegex).evaluate(with: flat)
    }
    
    
}
