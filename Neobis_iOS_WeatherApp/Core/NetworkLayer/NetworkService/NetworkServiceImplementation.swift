//
//  NetworkServiceImplementation.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 29.04.2023.
//

import Foundation

class NetworkServiceImplementation: NetworkService {
    
    private enum ApiCall {
        static let key = "10c23c3870e650a2d46ef9a8222dc0de"
        static let limit = 5
    }
    
    func getLocation(
        location: String,
        completion: @escaping NetworkServiceCompletion
    ) throws {
        
        guard let request = try? RequestBuilder<GeoRequest>
            .buildRequest(request: .cityName(cityName: location))
        else { throw NetworkServiceErrors.badRequest }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, nil, error)
            } else {
                completion (data, response, nil)
            }
        }
        task.resume()
    }
    
    func getWeatherData(location: LocationModel) async throws -> Data {
        
        guard let request = try? RequestBuilder<WeatherRequest>
            .buildRequest(request: .fiveDayForecast(location: location))
        else { throw NetworkServiceErrors.badRequest }
        
        let task = URLSession.shared
        
        let response = try await task.data(for: request)
        
        return response.0
        
    }
}

enum NetworkServiceErrors: String, Error {
    case badRequest = "Request is nil or unavailable"
    case badData = "Data is empty"
    case locationIsNil = "Location is nil or empty"
    case emptyWeatherModel = "weather model is empty or nil"
}
