//
//  NetworkService.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 27.04.2023.
//

import Foundation


protocol NetworkService: AnyObject {
    typealias NetworkServiceCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void
    func getLocation(
        location: String,
        completion: @escaping NetworkServiceCompletion
    ) throws
    
    func getWeatherData(location: LocationModel) async throws -> Data
}

