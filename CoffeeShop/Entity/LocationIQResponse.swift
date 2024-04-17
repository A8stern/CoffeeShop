//
//  LocationIQResponse.swift
//  CoffeeShop
//
//  Created by Kovalev Gleb on 10.04.2024.
//

struct LocationIQResponse: Codable {
    let placeID: String?
    let licence: String?
    let osmType, osmID, lat, lon: String?
    let displayName: String?
    let address: Address?
    let boundingbox: [String]?

    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case licence
        case osmType = "osm_type"
        case osmID = "osm_id"
        case lat, lon
        case displayName = "display_name"
        case address, boundingbox
    }
}

    // MARK: - Address
struct Address: Codable {
    let houseNumber, road, cityDistrict, city: String?
    let state, region, postcode, country: String?
    let countryCode: String?

    enum CodingKeys: String, CodingKey {
        case houseNumber = "house_number"
        case road
        case cityDistrict = "city_district"
        case city, state, region, postcode, country
        case countryCode = "country_code"
    }
}
