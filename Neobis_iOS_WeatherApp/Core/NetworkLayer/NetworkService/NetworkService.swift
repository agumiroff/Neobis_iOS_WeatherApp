//
//  NetworkService.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 27.04.2023.
//

import Foundation


protocol NetworkService: AnyObject {
    
    func getCoordinatesByLocationName(
        location: String,
        completion: @escaping (Result<[LocationModel], Error>) -> Void
    ) throws
    
    func getWeatherData(location: LocationModel) async throws -> WeatherModel
}

