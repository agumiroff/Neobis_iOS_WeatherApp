//
//  NetworkService.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 27.04.2023.
//

import Foundation

fileprivate enum ApiCall {
    static let key = "10c23c3870e650a2d46ef9a8222dc0de"
    static let limit = 1
    static let basicCall = "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid=\(key)"
}

protocol NetworkServiceProtocol {
    
    func getCoordinatesByLocationName(location: String)
    
    func getWeatherData(location: LocationModel)
}

class NetworkService: NetworkServiceProtocol {
    
    func getCoordinatesByLocationName(location: String) {
        let url = "http://api.openweathermap.org/geo/1.0/direct?q=\(location)&limit=\(ApiCall.limit)&appid=\(ApiCall.key)"
    }
    
    func getWeatherData(location: LocationModel) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(ApiCall.key)"
    }
        
}
