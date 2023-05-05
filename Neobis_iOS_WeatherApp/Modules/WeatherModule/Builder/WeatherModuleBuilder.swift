//
//  WeatherModuleBuilder.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 05.05.2023.
//

import Foundation
import UIKit

struct WeatherModuleBuilder {
    
    static func buildWeatherModule(
        coordinator: MainFlowCoordinator,
        data: WeatherModel,
        location: LocationModel
    ) -> UIViewController {
        
        let viewModel = WeatherViewModelImplementation(
            coordinator: coordinator,
            weatherData: WeatherModelDomain(
            location: location,
            weather: data
        ))
        
        let view = WeatherViewController()
        view.viewModel = viewModel
        
        return view
    }
}
