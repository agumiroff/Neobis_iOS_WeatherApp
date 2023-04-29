//
//  MainFactoryImplementation.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit

class ModuleFactoryImplementation: ModuleFactory {
    
    func buildMainScreen(coordinator: MainFlowCoordinator,
                         data: WeatherModel,
                         location: LocationModel) -> UIViewController {
        
        let viewModel = MainScreenViewModelImplementation()
        viewModel.weatherData = data
        viewModel.coordinator = coordinator
        
        let view = MainScreenViewController(location: location)
        view.viewModel = viewModel
        
        return view
    }
    
    func buildDetailScreen(coordinator: MainFlowCoordinator) -> UIViewController {
        
        let viewModel = SearchScreenViewModelImplementation()
        viewModel.coordinator = coordinator
        viewModel.networkService = DIContainer.standart.resolve()
        
        let view = SearchScreenVCImplementation()
        view.viewModel = viewModel
        
        return view
    }
}
