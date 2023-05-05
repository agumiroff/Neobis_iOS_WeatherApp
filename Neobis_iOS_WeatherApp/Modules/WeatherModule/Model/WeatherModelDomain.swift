//
//  WeatherModelDomain.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 05.05.2023.
//

import Foundation

struct WeatherModelDomain {
    let list: [WeekDayModelDomain]
    let icon: String
    let dt: Double
    let temperature: Double
    let humidity: Double
    let pressure: Double
    let windspeed: Double
    let visibility: Double
    let name: String
    let country: String
}

extension WeatherModelDomain {
    init(
        location: LocationModel,
        weather: WeatherModel
    ) {
        self.icon = weather.list.first?.weather.first?.icon ?? "10d"
        self.dt = weather.list.first?.dt ?? 0.0
        self.humidity = weather.list.first?.main["humidity"] ?? 0.0
        self.pressure = weather.list.first?.main["pressure"] ?? 0.0
        self.temperature = weather.list.first?.main["temp"] ?? 0.0
        self.windspeed = weather.list.first?.wind["speed"] ?? 0.0
        self.visibility = weather.list.first?.visibility ?? 0.0
        self.country = location.country
        self.name = location.name
        
        self.list = {
            var weekDayData = [WeekDayModelDomain]()
            
            var currentDate = NSDate.now
            
            guard let weatherList = weather.list else { return }
            
            for day in weatherList {
                
                let calendar = Calendar.current
                
                let date = calendar.dateComponents([.day], from: Date(timeIntervalSince1970: day.dt))
                let dateDay = date.day
                
                let nextDayDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
                let nextDay = calendar.dateComponents([.day], from: nextDayDate).day
                
                if dateDay == nextDay {
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "EEEE"
                    
                    weekDayData.append(WeekDayModelDomain(weatherModelDomain: day))
                    
                    currentDate = nextDayDate
                }
            }
            return weekDayData
        }()
    }
}
