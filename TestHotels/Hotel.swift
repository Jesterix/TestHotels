//
//  Hotel.swift
//  TestHotels
//
//  Created by Георгий Хайденко on 25.06.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

struct Hotel: Codable {
    let id: Int
    let name: String
    let address: String
    let stars: Double
    let distance: Double
    let suitesAvailability: [String]

    enum CodingKeys: String, CodingKey {
        case id, name, address, stars, distance
        case suitesAvailability = "suites_availability"
    }

    init(
        id: Int,
        name: String,
        address: String,
        stars: Double,
        distance: Double,
        suitesAvailability: String)
    {
        self.id = id
        self.name = name
        self.address = address
        self.stars = stars
        self.distance = distance
        self.suitesAvailability = suitesAvailability.components(separatedBy: ":")
    }
}
