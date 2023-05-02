//
//  WeatherModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 29.04.2023.
//

import Foundation

struct WeatherModel: Codable {
    let list: [WeatherList]
}

struct Weather: Codable {
    let description: String
    let icon: String
    
}

struct WeatherList: Codable {
    let dt: Double
    let main: Dictionary<String, Double>
    let weather: [Weather]
    let wind: Dictionary<String, Double>
    let visibility: Double
}
