//
//  SearchModuleBuilder.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 05.05.2023.
//

import Foundation
import UIKit

struct SearchModuleBuilder {
    
    static func buildSearchModule(
        coordinator: MainFlowCoordinator
    ) -> UIViewController {
        
        let viewModel = SearchScreenViewModelImplementation()
        viewModel.coordinator = coordinator
        viewModel.networkService = DIContainer.standart.resolve()
        
        let view = SearchViewController()
        view.viewModel = viewModel
        
        return view
        
    }
}
