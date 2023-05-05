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
    ) {
        let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(location)&limit=\(ApiCall.limit)&appid=\(ApiCall.key)"
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in

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
    
    func getWeatherData(
        location: LocationModel,
        completion: @escaping (Result<WeatherModel, Error>) -> Void
    ) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.lat)&lon=\(location.lon)&appid=\(ApiCall.key)&units=metric"
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error)) // log error
                return
            }
            
            do {
                guard let data = data else { return }
                let dataFromJSON = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(.success(dataFromJSON))
            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    func getWeatherDataAsync(location: LocationModel) async throws -> WeatherModel {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.lat)&lon=\(location.lon)&appid=\(ApiCall.key)&units=metric"
        
        guard let url = URL(string: urlString) else { throw  NetworkError.badUrl}
        
        let responce = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let result = try decoder.decode(WeatherModel.self, from: responce.0)
        
        return result
    }

}

enum callResult {
    case success
    case failure
}
