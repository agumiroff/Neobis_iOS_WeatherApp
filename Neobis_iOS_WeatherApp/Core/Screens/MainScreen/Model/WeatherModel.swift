//
//  WeatherModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 29.04.2023.
//

import Foundation

struct WeatherModel: Codable {
    let weather: [Weather]
    let main: Dictionary<String, Double>
    let visibility: Double
    let wind: Dictionary<String, Double>
//    let wind: [Wind]
}

struct Weather: Codable {
    let id: Int
    
    let description: String
    let icon: String
    
}

//struct Main {
//    let temp: Double
//    let humidity: Double
//    let pressure: Double
//}

