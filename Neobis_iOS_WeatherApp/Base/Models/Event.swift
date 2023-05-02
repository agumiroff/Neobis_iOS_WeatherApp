//
//  Events.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 02.05.2023.
//

import Foundation

enum Event {
    case startSearch
    case finishSearch(result: SearchResult)
    case showWeather
    case cancelSearch
    
    enum SearchResult {
        case success
        case failure
    }
}
