//
//  WeekDayDomainModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 05.05.2023.
//

import Foundation

struct WeekDayModelDomain {
    let weatherImage: String
    let day: String
    let temperature: String
}

extension WeekDayModelDomain {
    init(weatherModelDomain: WeatherList) {
        
        let dateFormatter = DateFormatter()
        
        self.day = "\(dateFormatter.string(from: Date(timeIntervalSince1970: weatherModelDomain.dt)))"
        self.weatherImage = "https://openweathermap.org/img/wn/\(weatherModelDomain.weather.first?.icon ?? "10d").png"
        self.temperature = "\(Int(weatherModelDomain.main["temp"] ?? 0.0))°C"
    }
}
