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
        static let basicCall = "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid=\(key)"
    }
    
    func getCoordinatesByLocationName(location: String, completion: @escaping (Result<[LocationModel], Error>) -> Void) {
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
    
    func getWeatherData(location: LocationModel, completion: @escaping (WeatherModel) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.lat)&lon=\(location.lon)&appid=\(ApiCall.key)"
        
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    guard let result = try? JSONDecoder().decode(WeatherModel.self, from: data) else { return }
                    completion(result)
                }
            }
        }
    }
        
}
