//
//  LocationModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 27.04.2023.
//

import Foundation

struct LocationModel: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
}
