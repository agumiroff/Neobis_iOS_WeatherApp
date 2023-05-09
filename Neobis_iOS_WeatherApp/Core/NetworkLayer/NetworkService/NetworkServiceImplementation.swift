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
    
    func getCoordinatesByLocationName(
        location: String,
        completion: @escaping (Result<[LocationModel], Error>) -> Void
    ) throws {
        
        guard let request = try? RequestBuilder<GeoRequest>
            .buildRequest(request: .cityName(cityName: location))
        else { throw NetworkServiceErrors.badRequest }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error)) // log error
                return
            }
            
            do {
                guard let data = data else { return }
                let dataFromJSON = try JSONDecoder().decode([LocationModel].self, from: data)
                completion(.success(dataFromJSON))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getWeatherData(location: LocationModel) async throws -> WeatherModel {
        
        guard let request = try? RequestBuilder<WeatherRequest>
            .buildRequest(request: .fiveDayForecast(location: location))
        else { throw NetworkServiceErrors.badRequest }
        
        let task = URLSession.shared
        let decoder = JSONDecoder()
        let responce = try await task.data(for: request)
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let result = try decoder.decode(WeatherModel.self, from: responce.0)
        
        return result
        
    }
}

enum NetworkServiceErrors: String, Error {
    case badRequest = "Request is nil or unavailable"
    case badData = "Data is empty"
    case locationIsNil = "Location is nil or empty"
    case emptyWeatherModel = "weather model is empty or nil"
}
