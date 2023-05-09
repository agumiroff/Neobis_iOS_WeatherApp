//
//  WeatherRequest.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 09.05.2023.
//

import Foundation

enum WeatherRequest {
    case fiveDayForecast(location: LocationModel)
    case currentWeather(location: LocationModel)
    case weatherMaps
}

extension WeatherRequest: RequestType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.openweathermap.org") else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .currentWeather:
            return "data/2.5/weather"
        case .fiveDayForecast:
            return "data/2.5/forecast"
        case .weatherMaps:
            return "maps"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var config: RequestConfig {
        switch self {
            
            
        case let .fiveDayForecast(location),
            let .currentWeather(location):
            return .withParameters(
                bodyParameters: nil,
                urlParameters: [
                    "lat": location.lat,
                    "lon": location.lon,
                    "units":"metric",
                    "appid": NetworkManager.ApiCall.key,
                    "limit": 5,
                ]
            )
        case .weatherMaps:
            return .withParameters(
                bodyParameters: nil,
                urlParameters: [
                    "units":"metric",
                    "key":NetworkManager.ApiCall.key,
                    "limit": 5,
                ]
            )
        }
    }
}
