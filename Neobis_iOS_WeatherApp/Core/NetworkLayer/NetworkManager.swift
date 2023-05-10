//
//  NetworkService.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 09.05.2023.
//

import Foundation
import Swinject

struct NetworkManager {
    
    enum ApiCall {
        static let key = "10c23c3870e650a2d46ef9a8222dc0de"
        static let limit = 5
    }
    
    let networkService = NetworkServiceImplementation()
   
    func getLocation(cityName: String) -> [LocationModel] {
        
        var locations = [LocationModel]()
        
        try? networkService.getLocation(location: cityName,
                                        completion: { data, response, error in
            do {
                guard let data = data else { return }
                let dataFromJSON = try JSONDecoder().decode([LocationModel].self, from: data)
                locations = dataFromJSON
            } catch {
                print(error)
            }
        })
        
        return locations
    }
    
    func getWeather() {
        
    }
}
