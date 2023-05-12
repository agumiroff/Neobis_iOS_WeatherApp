//
//  LastWeatherData+CoreDataProperties.swift
//  
//
//  Created by G G on 12.05.2023.
//
//

import Foundation
import CoreData
import UIKit


@objc(WeatherModelCD)
public class WeatherModelCD: NSManagedObject {}

public extension WeatherModelCD {
    
    @nonobjc class
    func fetchRequest() -> NSFetchRequest<WeatherModelCD> {
        return NSFetchRequest<WeatherModelCD>(entityName: "WeatherModelCD")
    }
    
    @NSManaged var list: [NSObject]
}

// struct WeatherModelAPI: Codable {
//     let list: [WeatherList]
// }
//
// struct Weather: Codable {
//     let description: String
//     let icon: String
// }
//
// struct WeatherList: Codable {
//     let dt: Double
//     let main: [String: Double]
//     let weather: [Weather]
//     let wind: [String: Double]
//     let visibility: Double
// }
 
