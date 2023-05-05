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
        data: WeatherModel?,
        location: LocationModel,
        state: WeatherViewController.WeatherState
    ) -> UIViewController {
        
        let viewModel = WeatherViewModelImplementation()
        viewModel.weatherData = data
        viewModel.coordinator = coordinator
        viewModel.location = location
        viewModel.state.accept(state)
        
        let view = WeatherViewController()
        view.viewModel = viewModel
        
        return view
    }
}
